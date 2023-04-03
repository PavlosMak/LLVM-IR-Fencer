import unittest
import os

from fence_insertion.points_to import SVF


class MyTestCase(unittest.TestCase):

    def test_memLocation(self):
        local_path = os.getcwd()
        WPA_PATH = f"{local_path}/../SVF-SVF-2.2/Release-build/bin/wpa"
        svf = SVF(WPA_PATH)
        a = svf.run(f"{local_path}/../test_programs/add.ll")
        self.assertEqual(True, False)  # add assertion here


if __name__ == '__main__':
    unittest.main()
