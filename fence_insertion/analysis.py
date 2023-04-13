import llvmlite.binding as llvm
from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.aeg import AbstractEvent
from fence_insertion.instructions import *
from fence_insertion.pointer_analysis import SVF
from fence_insertion.pointer_analysis import MemAccessDirection


class ProgramIterator(object):
    """
    This is allows for a global way to iterate over a program.
    Follows the generator design pattern.
    """

    def __init__(self, instructions: list):
        self.instructions = instructions
        self.finger = 0
        self.stacking = []

    def __iter__(self):
        return self

    def __next__(self):
        return self.next()

    def __len__(self):
        """
        Returns the cardinality of the remaining instructions set.
        """
        return len(self.instructions) - self.finger

    def next(self):
        if self.finger < len(self.instructions):
            cur = self.instructions[self.finger]
            self.finger += 1
            return cur
        return None

    # Function to jump to a certain line number if required
    def jump(self, line_number: int):
        succesful_jump = False
        for i in range(len(self.instructions)):
            if self.instructions[i].program_point == line_number:
                self.finger = i
                succesful_jump = True
                break
        if not succesful_jump:
            print("jump failed: " + str(line_number))

    def getLineNumber(self):
        return self.finger

    def stack(self, line_number):
        self.stacking.append(line_number)

    def unstack(self):
        if len(self.stacking) == 0:
            return None
        return self.stacking.pop()


class ProgramAnalyser:
    def __init__(self, path_to_file: str, path_to_WPA: str, parse_as_bitcode=False):
        self.ir_txt = ""
        self.ir_lines = []
        self.shared_vars = []
        # Perform points to analysis
        self.points_to_analyzer = SVF(path_to_WPA)
        self.mem_accesses = self.points_to_analyzer.run(path_to_file)
        # Pass over the file and extract labels and line numbers (program points)
        self.labels = dict()
        self.function_lines = dict()
        self.declared_funcs = set()
        with open(path_to_file) as assembly_file:
            line_number = 0
            for line in assembly_file:
                line_number += 1
                self.ir_txt += line + "\n"
                parsed_line = Line(line, line_number)
                self.ir_lines.append(parsed_line)
                # Unfortunately there is no good way to get
                # a blocks label (and line number): https://github.com/numba/llvmlite/issues/603
                if ":" in parsed_line.code and (
                        not parsed_line.code.startswith(";") and not parsed_line.code.startswith("target")):
                    self.labels.update({parsed_line.code[0:parsed_line.code.index(":")]: parsed_line.line_number})
                if "define" in parsed_line.code:
                    func_name = parsed_line.code[parsed_line.code.index("@") + 1:parsed_line.code.index("(")]
                    self.function_lines.update({func_name: line_number})
                elif "declare" in parsed_line.code:
                    # We keep track of any function that is declared but not defined
                    func_name = parsed_line.code[parsed_line.code.index("@") + 1:parsed_line.code.index("(")]
                    self.declared_funcs.add(func_name)
                elif parsed_line.code[0] == "@":
                    # we found a shared variable in the LLVM IR
                    self.shared_vars.append(parsed_line.code.split(" ")[0])
        # Parse the code
        if not parse_as_bitcode:
            self.module = llvm.parse_assembly(self.ir_txt)
        else:
            self.module = llvm.parse_bitcode(self.ir_txt)
        # Initialize the graph
        print(self.shared_vars)
        print(self.labels)
        print(self.declared_funcs)
        print(self.function_lines)

        self.aeg = AbstractEventGraph()
        # Parse instructions and associate with memory analysis results
        self.parsed_instructions = list()

        # This holds code iterators for all functions (useful for the thread analysis)
        self.iterators = dict()
        for func in self.module.functions:
            # Check that we have the memory access for that function
            # this is important in cases where the function is called but not defined in the same file
            if func.name in self.declared_funcs:
                continue
            local_accesses = self.mem_accesses[func.name]
            definition_line = self.function_lines[func.name]
            line_num_offset = 0
            function_instructions = []
            for block in func.blocks:
                for instr in block.instructions:
                    line_num_offset += 1
                    txt_instr = str(instr).strip()
                    mem_access = None
                    if txt_instr in local_accesses:
                        ix = local_accesses.index(txt_instr)
                        mem_access = local_accesses[ix]
                    instr_line_num = definition_line + line_num_offset
                    parsed_instr = Instruction.create_instruction(instr, instr_line_num, mem_access)
                    if type(parsed_instr) == Assignment and hasattr(parsed_instr, "recursive") and type(
                            parsed_instr.recursive) == FunctionCall:
                        self.parsed_instructions.append(parsed_instr.recursive)
                        self.parsed_instructions.append(parsed_instr)

                        function_instructions.append(parsed_instr.recursive)
                        function_instructions.append(parsed_instr)
                    else:
                        self.parsed_instructions.append(parsed_instr)
                        function_instructions.append(parsed_instr)
            self.iterators.update({func.name: ProgramIterator(function_instructions)})
        self.program_iterator = ProgramIterator(self.parsed_instructions)

        self.program_iterator.jump(self.function_lines['main'] + 1)  # we want to start our analysis at main()

    def construct_aeg(self):
        self.construct_aeg_from_instruction(self.program_iterator, set())
        # self.construct_aeg_from_instruction(self.program_iterator.next(), set())

    def construct_aeg_from_instruction(self, iterator: ProgramIterator, prev_evts: set):
        """
        Incrementally creates the Abstract Event Graph, following the pseudocode
        of figure 15 in Alglave et al., 2014.
        """

        instr = iterator.next()
        # Base case
        if instr is None:
            return
        print(instr)
        print(instr.raw_string)
        self.program_iterator.getLineNumber()
        instr_type = type(instr)
        if instr_type == Assignment:
            str = instr.raw_string
            if "@" in str:
                var = str[str.find("@"):].split()[0]
                if var[-1] == ",":
                    var = var[:-1]
                if var in self.shared_vars:  # found actual shared var, so should be in the graph
                    if "load" in str:
                        events = [AbstractEvent(instr.program_point, MemAccessDirection.READ, mem_loc=var)]
                        self.aeg.add_pos_edges(prev_evts, events)
                        return self.construct_aeg_from_instruction(iterator, events)
                    elif "store" in str:
                        events = [AbstractEvent(instr.program_point, MemAccessDirection.WRITE, mem_loc=var)]
                        self.aeg.add_pos_edges(prev_evts, events)
                        return self.construct_aeg_from_instruction(iterator, events)
                    else:
                        print("error")
                        exit()
                else:
                    if "pthread_create":
                        print("thread_create")
                        thread_name = ""
                        # TODO: Extract in helper
                        # Get the function name from the thread and use that iterator to create the program
                        for func in self.function_lines.keys():
                            if func in instr.raw_string:
                                self.construct_aeg_from_instruction(self.iterators[func], prev_evts)
                        return self.construct_aeg_from_instruction(iterator, prev_evts)
                    return self.construct_aeg_from_instruction(iterator, prev_evts)
            else:
                # no shared vars found, so move on to the next instruction
                return self.construct_aeg_from_instruction(iterator, prev_evts)
        elif instr_type == FunctionCall:
            print("found function")
            # print(instr.raw_string)
            str = instr.raw_string
            if "@" in str:
                func = str[str.find("@") + 1:].split()[0]
                pos_bracket = func.find("(")
                func = func[:pos_bracket]
                if func in self.function_lines:
                    # function is defined within the file
                    # insert the location where we were onto a stack, so we can return to it after a ret instruction.
                    self.program_iterator.stack(instr.program_point + 1)
                    # print(self.program_iterator.stacking)
                    # jump to the new function so we can search for shared vars there
                    self.program_iterator.jump(self.function_lines[func] + 1)
                    return self.construct_aeg_from_instruction(iterator, prev_evts)

                else:
                    # function is some type of call, for example a print function
                    # since it is not something we should handle, we just try to go to the next instruction
                    return self.construct_aeg_from_instruction(iterator, prev_evts)

            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == Guard:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == UnconditionalForwardJmp:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == ConditionalBackwardJmp:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == Jmp:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == AssumeAssertSkip:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == AtomicSection:
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == NewThread:
            print("found new thread")
            return self.construct_aeg_from_instruction(iterator, set())
        elif instr_type == EndThread:
            print("found end thread")
            return self.construct_aeg_from_instruction(iterator, set())
        else:
            # print(instr.raw_string)
            # print("at line ")
            # print(instr.program_point)

            if "ret" in instr.raw_string:
                # print("found return function")
                new_instr = self.program_iterator.unstack()
                if new_instr == None:
                    # should be at the end of main, so this is the end of the program
                    return
                self.program_iterator.jump(new_instr)
            return self.construct_aeg_from_instruction(iterator, prev_evts)

    def get_aeg(self) -> AbstractEventGraph:
        """
        The correct way to access the AEG from the program analyser.
        It will create the AEG and return it upon request.
        """
        self.construct_aeg()
        return self.aeg
