import unittest
from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.aeg import AbstractEventGraphNode
from fence_insertion.aeg import AbstractEvent


class AbstracyEventGraphTests(unittest.TestCase):
    def test_tarjan(self):
        dummy_event = AbstractEvent(0, AbstractEvent.MemAccessDirection.READ, AbstractEvent.MemoryLoc(0))
        aeg = AbstractEventGraph()
        node0 = AbstractEventGraphNode(dummy_event, 0)
        node1 = AbstractEventGraphNode(dummy_event, 1)
        node2 = AbstractEventGraphNode(dummy_event, 2)
        node3 = AbstractEventGraphNode(dummy_event, 3)
        node4 = AbstractEventGraphNode(dummy_event, 4)
        node5 = AbstractEventGraphNode(dummy_event, 5)
        node6 = AbstractEventGraphNode(dummy_event, 6)

        aeg.add_edge(node0, node1)
        aeg.add_edge(node1, node2)
        aeg.add_edge(node1, node4)
        aeg.add_edge(node1, node6)
        aeg.add_edge(node2, node3)
        aeg.add_edge(node3, node2)
        aeg.add_edge(node3, node4)
        aeg.add_edge(node3, node5)
        aeg.add_edge(node4, node5)
        aeg.add_edge(node5, node4)
        aeg.add_edge(node6, node0)
        aeg.add_edge(node6, node2)

        print(aeg.tarjan())
        # self.assertEqual([[5, 4], [3, 2], [6, 1, 0]], aeg.tarjan())


if __name__ == '__main__':
    unittest.main()
