import unittest
import instructions

class TestStringMethods(unittest.TestCase):

    def test_assignment(self):
        line_instruction = "  %3 = load i32, i32* @globvar, align 4"
        cons = instructions.Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertEqual("%3", temp.lhs)
        self.assertEqual("load i32, i32* @globvar, align 4", temp.rhs)

    def test_assignment_function(self):
        line_instruction = "  %9 = call i32 (...) @nondet()"
        cons = instructions.Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertEqual("%9", temp.lhs)
        self.assertEqual("call i32 (...) @nondet()", temp.rhs)
        self.assertIsInstance(temp.recursive, instructions.FunctionCall)
        self.assertEqual("nondet", temp.recursive.function_name)

    def test_functionCall(self):
        line_instruction = "  call void @unlock()"
        cons = instructions.Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, instructions.FunctionCall)
        self.assertEqual("unlock", temp.function_name)

    def test_guardCall(self):
        line_instruction = "%5 = icmp eq i32 %4, 0"
        cons = instructions.Instruction(10)
        temp = cons.create_instruction(line_instruction)
        self.assertIsInstance(temp, instructions.Assignment)
        self.assertIsInstance(temp.recursive, instructions.Guard)
        self.assertEqual("eq", temp.recursive.comparision_type)

if __name__ == '__main__':
    unittest.main()

