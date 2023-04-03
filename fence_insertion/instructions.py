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
    #TODO: Change program_point to be a Line instead of just a number
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
        Creates a new assignment instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split(" = ")
        self.lhs = split[0].replace(" ", "")
        self.rhs = split[1].strip() #TODO: Instruction
        split_rhs = self.rhs.split(" ")
        if split_rhs[0] == "call": #fucntion call
            FunctionCall(self.rhs, program_point)
        

    def evts(self) -> set:
        pass

    def trg(self) -> set:
        pass


class FunctionCall(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new assignment instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split("@")
        function_call = split[1] #full function call
        split_function_call = function_call.split("(")
        self.function_call_name = split_function_call[0]
        function_call_params = split_function_call[1]
        function_call_params


        

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
