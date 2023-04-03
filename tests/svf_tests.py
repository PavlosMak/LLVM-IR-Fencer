import unittest
import os

from fence_insertion.points_to import SVF


class MyTestCase(unittest.TestCase):

    def smoke_test_memLocation(self):
        local_path = os.getcwd()
        WPA_PATH = f"{local_path}/../SVF-SVF-2.2/Release-build/bin/wpa"
        svf = SVF(WPA_PATH)
        svf.run(f"{local_path}/../test_programs/add.ll")


if __name__ == '__main__':
    unittest.main()
