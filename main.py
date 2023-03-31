import argparse
import os

from fence_insertion.insertion import FenceInserter

# Make argument parser
parser = argparse.ArgumentParser(
    prog="Fence Insertion for LLVM",
    description="Automatically inserts fence instructions in LLVM IR")
parser.add_argument("--compile-tests", action="store_true", help="Compiles test programs")
parser.add_argument("--run", action="store_true", help="Runs the test programs")


def run():
    '''Runs the test programs through the fence insertion pass.
    Note that they need to be compiled first by running `compile-tests`.'''
    for file in os.listdir("./testPrograms"):
        if file.endswith(".ll"):
            pass


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # TODO: add utilities
    # TODO: make graph
    inserter = FenceInserter("test_programs/add.ll")
    inserter.construct_aeg()