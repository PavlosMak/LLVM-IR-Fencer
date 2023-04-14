from collections import defaultdict
from fence_insertion.pointer_analysis import MemAccessDirection


class AbstractEvent:

    def __init__(self, program_point: int, direction: MemAccessDirection, mem_loc: str):
        """
        Creates a new AbstractEvent
        :param program_point: The program point (line number event occurs in).
        :param direction: The direction of accessing the memory (reading or writing).
        :param mem_loc: The memory location being accessed.
        """
        self.program_point = program_point
        self.direction = direction
        self.memory_loc = mem_loc

    def __hash__(self):
        return hash((self.program_point, self.direction))

    def __repr__(self):
        return f"AbstractEvent({self.program_point}, {self.direction}, {self.memory_loc})"

    def __str__(self):
        return self.__repr__()


class AbstractEventGraphNode:
    def __init__(self, abstract_event: AbstractEvent, id: int):
        self.abstract_event = abstract_event
        self.id = id

    def __hash__(self):
        return self.id

    def __repr__(self):
        return f"AbstractEventGraphNode({self.id}, {self.abstract_event})"

    def __str__(self):
        return self.__repr__()


class AbstractEventGraph:

    def __init__(self):
        self.edges = dict()  # Here we will store the adjacency list
        self.po_edges = []  # List of tuples to hold all pos edges. Useful for ILP
        self.time = 0
        self.cycles = list()
        self.vertexCount = 0
        self.recorded_events = dict()
        self.delays = []  # list of tuples representing a `delay` edge

    def record_event(self, abstract_event: AbstractEvent) -> AbstractEventGraphNode:
        """
        Records an event into the graph.

        :param abstract_event: The AbstractEvent to record.
        :returns: The created AbstractEventGraphNode.
        """
        if abstract_event in self.recorded_events:
            return self.recorded_events[abstract_event]
        node = AbstractEventGraphNode(abstract_event, self.vertexCount)
        self.recorded_events.update({abstract_event: node})
        self.add_node(node)
        return node

    def add_node(self, node: AbstractEventGraphNode):
        self.vertexCount += 1
        self.edges.update({node: list()})

    def add_edge(self, from_node: AbstractEventGraphNode, to_node: AbstractEventGraphNode, is_po: bool = True):
        if from_node not in self.edges:
            self.add_node(from_node)
        self.edges[from_node].append(to_node)
        # Check if the edge is a delay as defined in figure 7 for x86
        if is_po and from_node.abstract_event.direction == MemAccessDirection.WRITE and to_node.abstract_event.direction == MemAccessDirection.READ:
            self.delays.append((from_node, to_node))
        if is_po:
            self.po_edges.append((from_node, to_node))
        print(from_node.abstract_event.direction)
        print(from_node.abstract_event.memory_loc)
        print(to_node.abstract_event.direction)
        print(to_node.abstract_event.memory_loc)

    def add_cmp_edge(self, from_node: AbstractEventGraphNode, to_node: AbstractEventGraphNode):
        self.add_edge(from_node, to_node, is_po=False)
        self.add_edge(to_node, from_node, is_po=False)

    def add_pos_edges(self, events1: set, events2: set):
        """
        Adds edges between the abstract events in the events1 set
        and the abstract events in the events2 set.
        For every event that is not associated with a node, a new node
        is created.

        :param events1: Set of AbstractEvent objects.
        :param events2: Set of AbstractEvent objects.
        """
        nodes1 = [self.record_event(event) for event in events1]
        nodes2 = [self.record_event(event) for event in events2]
        for node1 in nodes1:
            for node2 in nodes2:
                self.add_edge(node1, node2)

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
