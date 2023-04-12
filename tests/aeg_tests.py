import unittest
from fence_insertion.aeg import AbstractEventGraph
from fence_insertion.aeg import AbstractEventGraphNode
from fence_insertion.aeg import AbstractEvent
from fence_insertion.pointer_analysis import MemAccessDirection


class AbstractEventGraphTests(unittest.TestCase):
    def test_tarjan(self):
        dummy_event = AbstractEvent(0, MemAccessDirection.READ, "%0")
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

        actual_ids = [[node.id for node in cycle] for cycle in aeg.tarjan()]
        expected_ids = [[5, 4], [3, 2], [6, 1, 0]]
        self.assertEqual(expected_ids, actual_ids)

    def test_tarjan_2_isolated(self):
        dummy_event = AbstractEvent(0, MemAccessDirection.READ, "%0")
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
        aeg.add_edge(node3, node4)
        aeg.add_edge(node3, node5)
        aeg.add_edge(node4, node5)
        aeg.add_edge(node5, node4)
        aeg.add_edge(node6, node0)
        aeg.add_edge(node6, node2)

        actual_ids = [[node.id for node in cycle] for cycle in aeg.tarjan()]
        expected_ids = [[5, 4], [3], [2], [6, 1, 0]]
        self.assertEqual(expected_ids, actual_ids)

    def test_add_pos_edges(self):
        aeg = AbstractEventGraph()

        event1 = AbstractEvent(0, MemAccessDirection.READ, "loc1")
        event2 = AbstractEvent(0, MemAccessDirection.WRITE, "loc1")
        event3 = AbstractEvent(1, MemAccessDirection.WRITE, "loc2")

        aeg.add_pos_edges({event1}, {event2})
        aeg.add_pos_edges({event1}, {event3})
        aeg.add_pos_edges({event3}, {event2})

        edges = list(aeg.edges.values())

        # Not the strongest assertion but good enough (also verified manually)
        self.assertEqual(2, len(edges[0]))
        self.assertEqual(0, len(edges[1]))
        self.assertEqual(1, len(edges[2]))


if __name__ == '__main__':
    unittest.main()
