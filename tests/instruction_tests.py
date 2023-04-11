import unittest
from fence_insertion.instructions import *
from unittest import mock


class AssignmentTests(unittest.TestCase):
    def test_creation(self):
        ir = " %8 = load i32, i32* %3, align 4"
        instr = Assignment(ir, 0)
        self.assertEqual("%8", instr.lhs)
        self.assertEqual("load i32, i32* %3, align 4", instr.rhs)
        self.assertEqual(0, instr.program_point)

    def test_assignment(self):
        line_instruction = "  %3 = load i32, i32* @globvar, align 4"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertEqual("%3", temp.lhs)
        self.assertEqual("load i32, i32* @globvar, align 4", temp.rhs)
        self.assertEqual({"%3"}, temp.writes)
        self.assertEqual(set(), temp.reads)

    def test_assignment_writes_reads(self):
        line_instruction = "%2 = add nsw i32 %4, 3"  # writes %2, reads %4
        line_instruction2 = "%2 = add nsw i32 %4, %5"  # writes %2, reads %4, %5
        instr1 = Instruction.create_instruction(line_instruction, 10)
        instr2 = Instruction.create_instruction(line_instruction2, 10)
        self.assertEqual({"%2"}, instr1.writes)
        self.assertEqual({"%2"}, instr2.writes)
        self.assertEqual({"%4"}, instr1.reads)
        self.assertEqual({"%4", "%5"}, instr2.reads)

    def test_store_reads_writes(self):
        line_instruction1 = "store i32 %0, i32* %2, align 4"
        line_instruction2 = "store i32 42, i32* %2, align 4"
        instr1 = Instruction.create_instruction(line_instruction1, 10)
        instr2 = Instruction.create_instruction(line_instruction2, 10)
        self.assertEqual({"%0"}, instr1.reads)
        self.assertEqual(set(), instr2.reads)
        self.assertEqual({"%2"}, instr1.writes)
        self.assertEqual({"%2"}, instr2.writes)

    def test_load_reads_writes(self):
        line_instruction1 = "%6 = load i32, i32* %2, align 4"
        instr1 = Instruction.create_instruction(line_instruction1, 10)
        self.assertEqual({"%6"}, instr1.writes)
        self.assertEqual({"%2"}, instr1.reads)

    def test_assignment_function(self):
        line_instruction = "  %9 = call i32 (...) @nondet()"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertEqual("%9", temp.lhs)
        self.assertEqual("call i32 (...) @nondet()", temp.rhs)
        self.assertIsInstance(temp.recursive, FunctionCall)
        self.assertEqual("nondet", temp.recursive.function_name)

    def test_functionCall(self):
        line_instruction = "  call void @unlock()"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, FunctionCall)
        self.assertEqual("unlock", temp.function_name)

    def test_guardCall(self):
        line_instruction = "%5 = icmp eq i32 %4, 0"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, Assignment)
        self.assertIsInstance(temp.recursive, Guard)
        self.assertEqual("eq", temp.recursive.comparision_type)

    def test_jmp(self):
        line_instruction = "br label %12"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, Jmp)

    def test_jmp_conditional(self):
        line_instruction = "br i1 %14, label %15, label %19"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp.backCondJump[0], ConditionalBackwardJmp)

    def test_jmp_conditional_forward(self):
        isForwardJmp = mock.Mock()
        isForwardJmp.return_value = True
        line_instruction = "br i1 %14, label %15, label %19"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, Jmp)
        self.assertEqual(len(temp.backCondJump), 2)
        self.assertIsInstance(temp.backCondJump[0], ConditionalBackwardJmp)
        self.assertIsInstance(temp.backCondJump[1], ConditionalBackwardJmp)

    def test_create_thread(self):
        line_instruction = "call void @pthread_create()"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, NewThread)

    def test_join_thread(self):
        line_instruction = "call void @pthread_join()"
        temp = Instruction.create_instruction(line_instruction, 10)
        self.assertIsInstance(temp, EndThread)


if __name__ == '__main__':
    unittest.main()
