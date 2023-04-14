import argparse
import os
import time
import unittest

import tests.aeg_tests
import tests.instruction_tests
from fence_insertion.analysis import ProgramAnalyser
from fence_insertion.insertion import FenceInserter

# This is set in the main function, if you want to point it to a different location
# set it manually here and remove the corresponding line from main.
WPA_PATH = ""

# Make argument parser
parser = argparse.ArgumentParser(
    prog="Fence Insertion for LLVM",
    description="Automatically inserts fence instructions in LLVM IR")
parser.add_argument("--compile-tests", action="store_true", help="Compiles test programs")
parser.add_argument("--run", action="store_true", help="Runs the test programs")
parser.add_argument("--configure", action="store_true", help="Configures the tool")
parser.add_argument("--python-tests", action="store_true", help="Verify parsing")


def run():
    '''Runs the test programs through the fence insertion pass.
    Note that they need to be compiled first by running `compile-tests`.'''
    # dirs = ["test_programs", "test_programs/classic", "test_programs/fast"]
    dirs = ["test_programs", "test_programs/own"]
    parent_dir = os.getcwd()
    for directory in dirs:
        os.chdir(directory)
        for file in os.listdir():
            if file.endswith(".ll") and not file.startswith("fenced_"):
                print(f"Inserting fences on {file}")
                start = time.time()
                analyser = ProgramAnalyser(file, WPA_PATH)
                aeg = analyser.get_aeg()
                inserter = FenceInserter(aeg, analyser.ir_lines)
                inserter.insert_fences()
                inserter.export("fenced_" + file)
                end = time.time()
                print("\t--Done!")
                print(f"\t--Inserted: {inserter.fences_inserted} fences.")
                print(f"\t--Time: {end-start:.2f} seconds.")
        os.chdir(parent_dir)


def run_on_single_file(filename: str):
    """
    Runs the given test program through the fence insertion pass.
    Note that it needs to be compiled first by running `compile-tests`.
    """
    parent_dir = os.getcwd()
    os.chdir("test_programs/own")
    analyser = ProgramAnalyser(filename, WPA_PATH)
    inserter = FenceInserter(analyser.get_aeg(), analyser.ir_lines)
    inserter.insert_fences()
    inserter.export("fenced_" + filename)
    os.chdir(parent_dir)


def compile_tests():
    '''Compiles the test programs, of the `testPrograms` directory.'''
    dirs = ["test_programs", "test_programs/own"]
    parent_dir = os.getcwd()
    for directory in dirs:
        os.chdir(directory)
        for file in os.listdir():
            if file.endswith(".c"):
                os.system(f"clang-12 -S -emit-llvm {file}")
        os.chdir(parent_dir)


def python_test():
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(tests.instruction_tests.AssignmentTests)
    unittest.TextTestRunner().run(suite)
    suite1 = unittest.defaultTestLoader.loadTestsFromTestCase(tests.aeg_tests.AbstractEventGraphTests)
    unittest.TextTestRunner().run(suite1)


if __name__ == '__main__':
    # First set the path SVF
    local_path = os.getcwd()
    WPA_PATH = f"{local_path}/SVF-SVF-2.2/Release-build/bin/wpa"
    # Parse arguments and run
    parsed_args = parser.parse_args()

    if parsed_args.compile_tests:
        print("Compiling test programs...")
        compile_tests()
    elif parsed_args.run:
        run()
    elif parsed_args.python_tests:
        print("running python tests")
        python_test()
    else:
        run_on_single_file("peterson.ll")
