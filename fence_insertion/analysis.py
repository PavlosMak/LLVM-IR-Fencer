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


class ProgramAnalyser:
    def __init__(self, path_to_file: str, path_to_WPA: str, parse_as_bitcode=False):
        self.ir_txt = ""
        self.ir_lines = []
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

        # Parse the code
        if not parse_as_bitcode:
            self.module = llvm.parse_assembly(self.ir_txt)
        else:
            self.module = llvm.parse_bitcode(self.ir_txt)
        # Initialize the graph
        self.aeg = AbstractEventGraph()
        # Parse instructions and associate with memory analysis results
        self.parsed_instructions = list()
        for func in self.module.functions:
            # Check that we have the memory access for that function
            # this is important in cases where the function is called but not defined in the same file
            if func.name in self.declared_funcs:
                continue
            local_accesses = self.mem_accesses[func.name]
            definition_line = self.function_lines[func.name]
            line_num_offset = 0
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
                    else:
                        self.parsed_instructions.append(parsed_instr)
        self.program_iterator = ProgramIterator(self.parsed_instructions)

    def construct_aeg(self):
        self.construct_aeg_from_instruction(self.program_iterator.next(), set())

    def construct_aeg_from_instruction(self, instr: Instruction, prev_evts: set):
        """
        Incrementally creates the Abstract Event Graph, following the pseudocode
        of figure 15 in Alglave et al., 2014.
        """
        # Base case
        if instr is None:
            return
        instr_type = type(instr)
        if instr_type == Assignment:
            read_locations = instr.reads
            write_locations = instr.writes
            # If there is a memory access associated add it to correct set
            if instr.mem_access is not None:
                if instr.mem_access.direction == MemAccessDirection.READ:
                    read_locations.add(instr.mem_access.location)
                else:
                    write_locations.add(instr.mem_access.location)
            # TODO: Resolve registers to addresses

            # In contrast to the original paper we have only two sets of events because
            # LLVM IR will not have reads in both sides of an assignment
            evts2 = set(
                [AbstractEvent(instr.program_point, MemAccessDirection.READ, mem_loc) for mem_loc in read_locations])
            evts3 = set([AbstractEvent(instr.program_point, MemAccessDirection.WRITE, mem_loc) for mem_loc in
                         write_locations])

            self.aeg.add_pos_edges(prev_evts, evts2)
            self.aeg.add_pos_edges(evts2, evts3)

            return self.construct_aeg_from_instruction(self.program_iterator.next(), evts3)
        elif instr_type == FunctionCall:
            func_name = instr.function_name
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == Guard:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == UnconditionalForwardJmp:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == ConditionalBackwardJmp:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == Jmp:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == AssumeAssertSkip:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == AtomicSection:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == NewThread:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        elif instr_type == EndThread:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), set())
        else:
            return self.construct_aeg_from_instruction(self.program_iterator.next(), prev_evts)

    def get_aeg(self) -> AbstractEventGraph:
        """
        The correct way to access the AEG from the program analyser.
        It will create the AEG and return it upon request.
        """
        self.construct_aeg()
        return self.aeg
