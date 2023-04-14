from ortools.linear_solver import pywraplp
from ortools.sat.python import cp_model

from fence_insertion.aeg import AbstractEventGraph


class FenceInserter:
    def __init__(self, aeg: AbstractEventGraph, program: list):
        self.aeg = aeg
        self.program = program
        self.solver = cp_model.CpSolver()
        if not self.solver:
            raise RuntimeError("Could not create solver")

    def get_fences(self) -> list:
        # first find all the cycles
        cycles = self.aeg.tarjan()
        # find all delays that appear in a cycle
        delays = list(filter(lambda x: self.delay_in_cycle(x, cycles), self.aeg.delays))
        # make the model
        model = cp_model.CpModel()

        # create variables to optimize
        tls = [model.NewBoolVar(f"t{index}") for index, edge in enumerate(self.aeg.po_edges)]
        # add constraints
        for index, tl in enumerate(tls):
            if self.aeg.po_edges[index] in delays:
                model.AddAtLeastOne(tl)
        # add objective to the model
        model.Minimize(sum(tls))

        # Solve the problem
        self.solver.Solve(model)

        # Go through the tls to find which ones are set to true
        # and record that you need to insert a fence there.
        lines_to_be_fenced = []
        for index, tl in enumerate(tls):
            if self.solver.Value(tl) == 1:
                po_edge = self.aeg.po_edges[index]
                lines_to_be_fenced.append(
                    po_edge[1].abstract_event.program_point - 1)  # subtract 1 since we want the index
        return lines_to_be_fenced

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
        acc = 0
        for i in range(len(lines)):
            self.program.insert(lines[i] + acc, "\n  fence acq_rel\n")
            acc += 1

    def export(self, filename):
       with open(filename, 'w') as f:
           for line in self.program:
               f.write(str(line))