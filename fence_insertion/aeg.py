from collections import defaultdict
from fence_insertion.pointer_analysis import SVF
from fence_insertion.pointer_analysis import MemAccessDirection


class AbstractEvent:
    # This might be an overkill but not sure
    # how much detail we need.
    class MemoryLoc:
        def __init__(self, address: int):
            self.address = address

    def __init__(self, program_point: int, direction: MemAccessDirection, mem_loc: MemoryLoc):
        """
        Creates a new AbstractEvent
        :param program_point: The program point (line number event occurs in)
        :param direction: The direction of accessing the memory (reading or writing)
        :param mem_loc: The memory location being accessed
        """
        self.program_point = program_point
        self.direction = direction
        self.memory_loc = mem_loc


class AbstractEventGraphNode:
    def __init__(self, abstract_event: AbstractEvent, id: int):
        self.abstract_event = abstract_event
        self.id = id

    def __hash__(self):
        return self.id


class AbstractEventGraph:

    def __init__(self):
        self.edges = dict()  # Here we will store the adjacency list
        self.time = 0
        self.cycles = list()
        self.vertexCount = 0

    def record_event(self, abstract_event: AbstractEvent):
        node = AbstractEventGraphNode(abstract_event, self.vertexCount)
        self.add_node(node)

    def add_node(self, node: AbstractEventGraphNode):
        self.vertexCount += 1
        self.edges.update({node: list()})

    def add_edge(self, from_node: AbstractEventGraphNode, to_node: AbstractEventGraphNode):
        if from_node not in self.edges:
            self.add_node(from_node)
        self.edges[from_node].append(to_node)

    def tarjan_helper(self, u, low, disc, st):
        # Initialize discovery time and low value
        disc.update({u: self.time})
        low.update({u: self.time})
        self.time += 1
        st.append(u)

        # Go through all neighbors
        for v in self.edges[u]:
            if v not in disc:
                self.tarjan_helper(v, low, disc, st)
                low[u] = min(low[u], low[v])
            elif v in st:
                low[u] = min(low[u], disc[v])

        # Cycle found so store it
        w = -1
        if low[u] == disc[u]:
            cycle = []
            while w != u:
                w = st.pop()
                cycle.append(w)
            self.cycles.append(cycle)

    def tarjan(self) -> list:
        """
        Performs Tarjan's (1973) algorithm for cycle detection
        :return: A list of lists, each list represents a cycle (i.e. contains the nodes that comprise the cycle)
        """
        # Reset state
        self.cycles = []
        self.time = 0

        def default_value():
            return -1

        disc = defaultdict(default_value)
        low = defaultdict(default_value)
        st = []

        for v in self.edges.keys():
            if v not in disc:
                self.tarjan_helper(v, low, disc, st)

        return self.cycles
