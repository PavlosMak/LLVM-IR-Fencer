import unittest
import instructions

class TestStringMethods(unittest.TestCase):

    def test_assignment(self):
        line_instruction = "  %3 = load i32, i32* @globvar, align 4"
        temp = instructions.Assignment(line_instruction, 10)
        self.assertEqual("%3", temp.lhs)
        self.assertEqual("load i32, i32* @globvar, align 4", temp.rhs)

    def test_functionCall(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())


if __name__ == '__main__':
    unittest.main()

