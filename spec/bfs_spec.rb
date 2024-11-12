require "./lib/graph/bfs"

include BreadthFirstSearch

describe BreadthFirstSearch do

  # -----------------------------------------------------------------------------
  # Graph
  # -----------------------------------------------------------------------------

  graph_adj_list = {
    "A": ["B", "C"],
    "B": ["A", "D", "E"],
    "C": ["A", "F"],
    "D": ["B"],
    "E": ["B", "F"],
    "F": ["C", "E"]
  }

  # -----------------------------------------------------------------------------
  # Traversal
  # -----------------------------------------------------------------------------

  it "Test Case 1 - Breadth-First Search (BFS) Traversal" do

    input = "A"
    output = ["A", "B", "C", "D", "E", "F"]

    expect(BreadthFirstSearch::bfs_traversal(graph_adj_list, input)).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Pathlist
  # -----------------------------------------------------------------------------

  it "Test Case 2 - BFS Pathlist" do

    input = [graph_adj_list, 'A', 'F']
    output = [["A", "C", "F"], ["A", "B", "E", "F"]]

    path_list = []
    for path in BreadthFirstSearch::bfs_path_list(*input)
        path_list << path
    end
    expect(path_list).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Shortest Path
  # -----------------------------------------------------------------------------

  it "Test Case 3 - BFS Shortest Path" do

    input = [graph_adj_list, 'A', 'F']
    output = ["A", "C", "F"]

    expect(BreadthFirstSearch::bfs_shortest_path(*input)).to eq(output)
  end
end
