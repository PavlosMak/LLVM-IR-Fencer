from pathlib import Path
import llvmlite.binding as llvm
from aeg import AbstractEventGraph
from enum import Enum


class InstructionType(Enum):
    ASSIGNMENT = 1
    FUNCTION_CALL = 2
    GUARD = 3
    UNCONDITIONAL_FORWARD_JMP = 4
    CONDITIONAL_BACKWARD_JMP = 5
    ASSUME_ASSERT_SKIP = 6
    ATOMIC_SECTION = 7
    NEW_THREAD = 8
    END_THREAD = 9
    OTHER = 10


def get_block_info(block: llvm.ValueRef, ir_lines: list) -> (str, int):
    """
    Returns the label and the line associated with the block, if the block
    is explicitly labeled.
    :param block: The llvm block.
    :param ir_lines: An array containing every line of IR.
    :return: Tuple of (label: str, line_number: int) if labeled, else (None, None)
    """
    lines = str(block).split('\n')
    # return lines[1].index(':')
    if ":" in lines[1]:
        return lines[1][0:lines[1].index(":")], ir_lines.index(lines[1])
    return None, None


def instr_type(instr: llvm.ValueRef) -> InstructionType:
    return instr


class FenceInserter:
    def __init__(self, path_to_file: str, parse_as_assembly=True, parse_as_bitcode=False):
        self.ir_txt = Path(path_to_file).read_text()
        ir_lines = self.ir_txt.split("\n")
        # Parse the code
        parse_as_assembly = not parse_as_bitcode
        if parse_as_assembly:
            self.module = llvm.parse_assembly(self.ir_txt)
        else:
            self.module = llvm.parse_bitcode(self.ir_txt)
        # Extract labels
        self.labels = dict()
        for func in self.module.functions:
            for block in func.blocks:
                # Unfortunately there is no good way to get
                # a blocks label (and line number): https://github.com/numba/llvmlite/issues/603
                block_label, block_line = get_block_info(block, ir_lines)
                if block_label is not None:
                    self.labels.update({block_label: block_line})
        # Initialize the graph
        self.aeg = AbstractEventGraph()

    def construct_aeg(self):
        for func in self.module.functions:
            for block in func.blocks:
                for instr in block.instructions:
                    self.construct_aeg_from_instruction(instr)

    def construct_aeg_from_instruction(self, instr):
        print(instr_type(instr))

    def insert_fences(self):
        pass
