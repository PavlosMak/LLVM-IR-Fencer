from ortools.linear_solver import pywraplp
from ortools.init import pywrapinit

from fence_insertion.aeg import AbstractEventGraph


class FenceInserter:
    def __init__(self, aeg: AbstractEventGraph, program: list):
        self.aeg = aeg
        self.program = program
        self.solver = pywraplp.Solver.CreateSolver('GLOP')
        if not self.solver:
            raise RuntimeError("Could not create solver")

    def get_fences(self) -> list:
        cycles = self.aeg.tarjan()
        # find all delays that appear in a cycle
        delays = list(filter(lambda x: self.delay_in_cycle(x, cycles), self.aeg.delays))
        for delay in delays:
            print(delay)
        # for delay in self.aeg.delays:
        #     print(delay)
        return [10, 20]

    def delay_in_cycle(self, delay: tuple, cycles: list) -> bool:
        """
        Helper method to check if a delay appears in the set of cycles.

        :param delay: A tuple of AbstractEventGraphNodes, describing a delay edge.
        :param cycles: A list of lists, each nested list representing a cycle.
        :returns: True if the delay appears in one of the  cycles
        """
        for cycle in cycles:
            if (delay[0] in cycle) and (delay[1] in cycle):
                return True
        return False

    def insert_fences(self):
        # TODO: Replace this with actual
        lines = self.get_fences()  # The line numbers to insert full fences
        # acc = 0
        # for i in range(len(lines)):
        #     self.program.insert(lines[i] + acc, "fence")
        #     acc += 1
