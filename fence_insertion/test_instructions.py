import unittest
import instructions

class TestStringMethods(unittest.TestCase):

    def test_assignment(self):
        line_instruction = "  %3 = load i32, i32* @globvar, align 4"
        temp = instructions.Assignment(line_instruction, 10)
        self.assertEqual("%3", temp.lhs)
        self.assertEqual("load i32, i32* @globvar, align 4", temp.rhs)

    def test_assignment_function(self):
        line_instruction = "  %9 = call i32 (...) @nondet()"
        temp = instructions.Assignment(line_instruction, 10)
        self.assertEqual("%9", temp.lhs)
        self.assertEqual("call i32 (...) @nondet()", temp.rhs)
        self.assertIsInstance(temp.functionCall, instructions.FunctionCall)
        self.assertEqual("nondet", temp.functionCall.function_name)

    def test_functionCall(self):
        line_instruction = "  call void @unlock()"
        temp = instructions.FunctionCall(line_instruction, 10)
        self.assertIsInstance(temp, instructions.FunctionCall)
        self.assertEqual("unlock", temp.function_name)

if __name__ == '__main__':
    unittest.main()

