import llvmlite.binding as llvm
from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.instructions import Line
from fence_insertion.instructions import Instruction
from fence_insertion.pointer_analysis import SVF


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

    def construct_aeg(self):
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
                    parsed_instr = Instruction.create_instruction(instr, 0)
                    self.construct_aeg_from_instruction(instr)

    def construct_aeg_from_instruction(self, instr):
        # TODO call Instruction.create_instruction
        pass

    def get_aeg(self) -> AbstractEventGraph:
        """
        The correct way to access the AEG from the program analyser.
        It will create the AEG and return it upon request.
        """
        self.construct_aeg()
        return self.aeg
