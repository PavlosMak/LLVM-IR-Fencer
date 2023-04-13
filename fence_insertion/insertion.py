from fence_insertion.aeg import AbstractEventGraph

class FenceInserter:
    def __init__(self, aeg: AbstractEventGraph, program: list):
        self.aeg = aeg
        self.program = program

    def get_fences(self) -> list:
        return list(10, 20)
    def insert_fences(self):
        # TODO: Replace this with actual
        lines = self.get_fences() # The line numbers to insert full fences
        acc = 0
        for i in range(len(lines)):
            self.program.insert(lines[i]+acc, "fence")
            acc += 1

