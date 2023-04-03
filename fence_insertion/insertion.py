import llvmlite.binding as llvm

from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.instructions import Line
from fence_insertion.pointer_analysis import SVF

class FenceInserter:
    def __init__(self, path_to_file: str, parse_as_bitcode=False):
        self.ir_txt = ""
        self.ir_lines = []
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

    def construct_aeg(self):
        for func in self.module.functions:
            for block in func.blocks:
                for instr in block.instructions:
                    self.construct_aeg_from_instruction(instr)

    def construct_aeg_from_instruction(self, instr):
        # TODO call Instruction.create_instruction
        pass


    def insert_fences(self):
        print(self.ir_txt)