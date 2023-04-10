import llvmlite.binding as llvm
from fence_insertion.pointer_analysis import MemoryAccess


def isForwardJmp(line_number: int, label: str):
    return False


def find_method_name(instr: str):
    start_method_name = instr.find('@')
    end_method_name = instr.find('(')
    return instr[start_method_name + 1: end_method_name]


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
    # TODO: Change program_point to be a Line instead of just a number
    def __init__(self, program_point: int):
        """
        Creates a new instruction object
        :param program_point: The program point the instruction appears in (line number)
        """
        self.program_point = program_point
        self.mem_access = None

    def create_instruction(instr: llvm.ValueRef, program_point: int, mem_access: MemoryAccess = None):
        str_instr = str(instr)
        result_instr = None
        if '=' in str_instr:
            result_instr = Assignment(str_instr, program_point)
            result_instr.mem_access = mem_access
            return result_instr
        split_instr = str_instr.split()
        if split_instr[0] == "call":
            method_name = find_method_name(str_instr)
            if method_name == "pthread_create":
                result_instr = NewThread(str_instr, program_point)
            elif method_name == "pthread_join":
                result_instr = EndThread(str_instr, program_point)
            elif method_name == "__assert_fail":
                result_instr = AssumeAssertSkip(str_instr, program_point)
            else:
                result_instr = FunctionCall(str_instr, program_point)
        elif split_instr[0] == "load":
            result_instr = Assignment(str_instr, program_point)
        elif split_instr[0] == "store":
            result_instr = Assignment(str_instr, program_point)
        elif split_instr[0] == "icmp":
            result_instr = Guard(str_instr, 0)
        elif split_instr[0] == "br":
            result_instr = Jmp(str_instr, program_point)
        else:
            result_instr = OtherInstruction(str_instr, program_point)
        result_instr.mem_access = mem_access
        return result_instr


class Assignment(Instruction):

    def __init__(self, instr: str, program_point: int):
        """
        Creates a new assignment instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split(" = ")
        if len(split) == 2:
            self.lhs = split[0].replace(" ", "")
            self.rhs = split[1].strip()
            rec_instr = Instruction(program_point)
            self.recursive = Instruction.create_instruction(self.rhs, program_point)
        else:  # load or store instruction
            token = instr.split(" ")[0]
            if token == "load":
                rec_instr = Instruction(program_point)
                self.recursive = Instruction.create_instruction(instr[5:], program_point)
            else:  # store instruction
                rec_instr = Instruction(program_point)
                self.recursive = Instruction.create_instruction(instr[6:], program_point)


class FunctionCall(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new function call instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split("@")
        function_call = split[1]  # full function call

        param = function_call.split("(")
        self.function_name = param[0]  # contains the function call name


class Guard(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new guard instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        self.comparision_type = instr.split()[1]


class UnconditionalForwardJmp(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new unconditional instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)


class ConditionalBackwardJmp(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new unconditional instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)


# Every jump instruction can be simulated by a combination of a
# Unconditional forward jump and a conditional backward jump
class Jmp(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new unconditional instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        instr.replace(",", "")
        instr = instr.strip()
        tokens = instr.split(" ")
        self.backCondJump = []
        self.forwUnCondJump = []
        if tokens[1] != "label":  # defines conditional jump
            firstlabel = tokens[4][1:]
            secondlabel = tokens[6][1:]

            if isForwardJmp(program_point, firstlabel):
                self.forwUnCondJump.append(UnconditionalForwardJmp(instr, program_point))
            else:
                self.backCondJump.append(ConditionalBackwardJmp(instr, program_point))
            if isForwardJmp(program_point, secondlabel):
                self.forwUnCondJump.append(UnconditionalForwardJmp(instr, program_point))
            else:
                self.backCondJump.append(ConditionalBackwardJmp(instr, program_point))
        else:  # defines unconditional jump
            label = tokens[2][1:]
            if isForwardJmp(program_point, label):
                # unconditional forward jump
                self.forwUnCondJump.append(UnconditionalForwardJmp(instr, program_point))
                pass
            else:
                # unconditional backward jump
                # should not happen
                pass


class AssumeAssertSkip(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new assert instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        self.comparision_type = instr.split()[1]


class AtomicSection(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new atomic instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)


class NewThread(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new guard instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)


class EndThread(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new guard instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)


class OtherInstruction(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new guard instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
