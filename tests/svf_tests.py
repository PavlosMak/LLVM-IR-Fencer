import unittest
import os

from fence_insertion.pointer_analysis import SVF

class MyTestCase(unittest.TestCase):

    def test_smoke_memLocation(self):
        local_path = os.getcwd()
        WPA_PATH = f"{local_path}/../SVF-SVF-2.2/Release-build/bin/wpa"
        svf = SVF(WPA_PATH)
        svf.run(f"{local_path}/../test_programs/add.ll")
        self.assertTrue(True)


if __name__ == '__main__':
    unittest.main()
