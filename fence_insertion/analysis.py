import llvmlite.binding as llvm
from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.instructions import Line
from fence_insertion.instructions import *
from fence_insertion.pointer_analysis import SVF


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
        raise StopIteration()


class ProgramAnalyser:
    def __init__(self, path_to_file: str, path_to_WPA: str, parse_as_bitcode=False):
        self.ir_txt = ""
        self.ir_lines = []
        # Perform points to analysis
        points_to_analyzer = SVF(path_to_WPA)
        self.mem_accesses = points_to_analyzer.run(path_to_file)
        # Pass over the file and extract labels
        self.labels = dict()
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
            if func.name not in self.mem_accesses:
                continue
            local_accesses = self.mem_accesses[func.name]
            for block in func.blocks:
                for instr in block.instructions:
                    txt_instr = str(instr).strip()
                    mem_access = None
                    if txt_instr in local_accesses:
                        ix = local_accesses.index(txt_instr)
                        mem_access = local_accesses[ix]
                    parsed_instr = Instruction.create_instruction(instr, 0, mem_access)
                    self.parsed_instructions.append(parsed_instr)
        self.program_iterator = ProgramIterator(self.parsed_instructions)

    def construct_aeg(self):
        self.construct_aeg_from_instruction(self.program_iterator.next(), set())

    def construct_aeg_from_instruction(self, instr: Instruction, prev_evts: set):
        """
        Incrementally creates the Abstract Event Graph, following the pseudocode
        of figure 15 of Alglave et. al. 2014.
        """
        instr_type = type(instr)
        if instr_type == Assignment:
            # evts1 = self.get_abs_rds()
            print(instr_type)
        elif instr_type == FunctionCall:
            print(instr_type)
        elif instr_type == Guard:
            print(instr_type)
        elif instr_type == UnconditionalForwardJmp:
            print(instr_type)
        elif instr_type == ConditionalBackwardJmp:
            print(instr_type)
        elif instr_type == Jmp:
            print(instr_type)
        elif instr_type == AssumeAssertSkip:
            print(instr_type)
        elif instr_type == AtomicSection:
            print(instr_type)
        elif instr_type == NewThread:
            print(instr_type)
        elif instr_type == EndThread:
            print(instr_type)
        else:
            self.construct_aeg_from_instruction(self.program_iterator.next(), prev_evts)

    def get_aeg(self) -> AbstractEventGraph:
        """
        The correct way to access the AEG from the program analyser.
        It will create the AEG and return it upon request.
        """
        self.construct_aeg()
        return self.aeg

    def get_abs_rds(self, instruction: Instruction) -> set:
        """
        Returns the 'read' Abstract Events associated with the given instruction
        """
        pass

    def get_abs_wrs(self, instruction: Instruction) -> set:
        """
        Returns the 'write' Abstract Events associated with the given instruction
        """
        pass

    def add_pos_edges(self, evts1: set, evts2: set):
        """
        Mutates the object's Abstract Event Graph by creating edges between all the abstract
        events in evts1 and in evts2.

        @param evts1: A set of AbstractEvent objects
        @param evts2: A set of AbstractEvent objects
        """
        pass
