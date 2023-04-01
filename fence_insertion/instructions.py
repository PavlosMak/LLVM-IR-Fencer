import llvmlite.binding as llvm


class Line:
    def __init__(self, line: str, line_number: int = None):
        """
        Creates a new Line object
        :param line_number: The number of the line,by default none
        :param line: The code to be "parsed" into a line
        """
        self.line_number = line_number
        self.code = ""
        self.comments = ""
        if "; preds" in line:
            comment_index = line.index("; preds")
            self.code = line[0: comment_index]
            self.comments = line[comment_index:]
        else:
            self.code = line

    def __hash__(self):
        return self.code.__hash__()


class Instruction:
    def __init__(self, program_point: int):
        """
        Creates a new instruction object
        :param program_point: The program point the instruction appears in (line number)
        """
        self.program_point = program_point

    def create_instruction(instr: llvm.ValueRef):
        pass


class Assignment(Instruction):

    def __init__(self, instr: str, program_point: int):
        """
        Creates a new assingment instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split(" = ")
        self.lhs = split[0].replace(" ", "")
        self.rhs = split[1].strip()

    def evts(self) -> set:
        pass

    def trg(self) -> set:
        pass


class FunctionCall(Instruction):
    pass


class Guard(Instruction):
    pass


class UnconditionalForwardJmp(Instruction):
    pass


class AssumeAssertSkip(Instruction):
    pass


class AtomicSection(Instruction):
    pass


class NewThread(Instruction):
    pass


class EndThread(Instruction):
    pass


class OtherInstruction(Instruction):
    pass
