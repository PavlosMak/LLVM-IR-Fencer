import argparse
import os

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


def run():
    '''Runs the test programs through the fence insertion pass.
    Note that they need to be compiled first by running `compile-tests`.'''
    dirs = ["test_programs", "test_programs/classic", "test_programs/fast"]
    parent_dir = os.getcwd()
    for directory in dirs:
        os.chdir(directory)
        for file in os.listdir():
            if file.endswith(".ll"):
                f = FenceInserter(file)
        os.chdir(parent_dir)


def compile_tests():
    '''Compiles the test programs, of the `testPrograms` directory.'''
    dirs = ["test_programs", "test_programs/classic", "test_programs/fast"]
    parent_dir = os.getcwd()
    for directory in dirs:
        os.chdir(directory)
        for file in os.listdir():
            if file.endswith(".c"):
                os.system(f"clang-12 -S -emit-llvm {file}")
        os.chdir(parent_dir)


if __name__ == '__main__':
    # First set the path SVF
    local_path = os.getcwd()
    WPA_PATH = f"{local_path}/SVF-SVF-2.2/Release-build/bin/wpa"
    os.chdir("test_programs")
    os.system(f"{WPA_PATH} -ander  -svfg -dump-callgraph -print-pts add.ll")
    # Parse arguments and run
    parsed_args = parser.parse_args()
    if parsed_args.compile_tests:
        print("Compiling test programs...")
        compile_tests()
    if parsed_args.run:
        print("Inserting fences...")
        run()
