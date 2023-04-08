import unittest
from fence_insertion.instructions import *
from unittest import mock

class AssingmentTests(unittest.TestCase):
    def test_creation(self):
        ir = " %8 = load i32, i32* %3, align 4"
        instr = Assignment(ir, 0)
        self.assertEqual("%8", instr.lhs)
        self.assertEqual("load i32, i32* %3, align 4", instr.rhs)
        self.assertEqual(0, instr.program_point)

    def test_assignment(self):
        line_instruction = "  %3 = load i32, i32* @globvar, align 4"
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertEqual("%3", temp.lhs)
        self.assertEqual("load i32, i32* @globvar, align 4", temp.rhs)

    def test_assignment_function(self):
        line_instruction = "  %9 = call i32 (...) @nondet()"
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertEqual("%9", temp.lhs)
        self.assertEqual("call i32 (...) @nondet()", temp.rhs)
        self.assertIsInstance(temp.recursive, FunctionCall)
        self.assertEqual("nondet", temp.recursive.function_name)

    def test_functionCall(self):
        line_instruction = "  call void @unlock()"
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, FunctionCall)
        self.assertEqual("unlock", temp.function_name)

    def test_guardCall(self):
        line_instruction = "%5 = icmp eq i32 %4, 0"
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, Assignment)
        self.assertIsInstance(temp.recursive, Guard)
        self.assertEqual("eq", temp.recursive.comparision_type)

    def test_jmp(self):
        line_instruction = "br label %12"
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, Jmp)
        
    def test_jmp_conditional(self):
        line_instruction = "br i1 %14, label %15, label %19" 
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp.backCondJump[0], ConditionalBackwardJmp)

    def test_jmp_conditional_forward(self):
        isForwardJmp = mock.Mock()
        isForwardJmp.return_value = True
        line_instruction = "br i1 %14, label %15, label %19" 
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, Jmp)
        self.assertEqual(len(temp.backCondJump), 2)
        self.assertIsInstance(temp.backCondJump[0], ConditionalBackwardJmp)
        self.assertIsInstance(temp.backCondJump[1], ConditionalBackwardJmp)

    def test_create_thread(self):
        line_instruction = "call void @pthread_create()" 
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, NewThread)

    def test_join_thread(self):
        line_instruction = "call void @pthread_join()" 
        cons = Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, EndThread)
if __name__ == '__main__':
    unittest.main()
