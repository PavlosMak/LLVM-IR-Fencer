import unittest
from fence_insertion.instructions import Assignment


class AssingmentTests(unittest.TestCase):
    def test_creation(self):
        ir = " %8 = load i32, i32* %3, align 4"
        instr = Assignment(ir, 0)
        self.assertEqual("%8", instr.lhs)
        self.assertEqual("load i32, i32* %3, align 4", instr.rhs)
        self.assertEqual(0, instr.program_point)


if __name__ == '__main__':
    unittest.main()
