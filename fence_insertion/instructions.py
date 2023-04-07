import llvmlite.binding as llvm

def isForwardJmp(line_number: int, label: str):
    return False

def find_method_name(instr: str):
    #find characters between @ and (
    pass


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

    def create_instruction(self, instr: llvm.ValueRef):
        if '=' in instr:
            return Assignment(instr, self.program_point)
        split_instr = instr.split()
        if split_instr[0] == "call":
            method_name = find_method_name(instr)
            if method_name =="pthread_create":
                return NewThread(instr, self.program_point)
            elif method_name =="pthread_join":
                return EndThread(instr, self.program_point)
            elif method_name == "__assert_fail":
                return AssumeAssertSkip(instr, self.program_point)
            return FunctionCall(instr, self.program_point)
        
        elif split_instr[0] == "load":
            return Assignment(instr, self.program_point)
        elif split_instr[0] == "store":
            return Assignment(instr, self.program_point)
        elif split_instr[0] == "icmp":
            return Guard(instr, 0)
        elif split_instr[0] == "br":
            return Jmp(instr, self.program_point)
        
        else:
            return OtherInstruction(instr, self.program_point)


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
            self.recursive = rec_instr.create_instruction(self.rhs)
        else: #load or store instruction
            token = instr.split(" ")[0]
            if token == "load":
                rec_instr = Instruction(program_point)
                self.recursive = rec_instr.create_instruction(instr[5:])
            else: #store instruction
                rec_instr = Instruction(program_point)
                self.recursive = rec_instr.create_instruction(instr[6:])
            

    def evts(self) -> set:
        pass

    def trg(self) -> set:
        pass


class FunctionCall(Instruction):
    def __init__(self, instr: str, program_point: int):
        """
        Creates a new function call instruction
        :param instr: The textual representation of the instruction.
        """
        super().__init__(program_point)
        split = instr.split("@")
        function_call = split[1] #full function call
        
        param = function_call.split("(")
        self.function_name = param[0] #contains the function call name

        
        

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
        

class ConditionalBackwardJmp (Instruction):
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
        tokens = instr.split(" ")
        self.backCondJump = []
        self.forwUnCondJump = []
        if tokens[1] != "label": #defines conditional jump
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
        else: #defines unconditional jump
            label = tokens[2][1:]
            if isForwardJmp(program_point, label):
                #unconditional forward jump
                self.forwUnCondJump.append(UnconditionalForwardJmp(instr, program_point))
                pass      
            else: 
                #unconditional backward jump 
                #should not happen
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
