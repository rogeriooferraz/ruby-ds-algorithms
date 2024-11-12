require "./lib/graph/dfs"

include DepthFirstSearch

describe DepthFirstSearch do

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

  it "Test Case 1 - Depth-First Search (DFS) Traversal" do

    input = "A"
    output = ["A", "B", "D", "E", "F", "C"]

    expect(DepthFirstSearch::dfs_traversal(graph_adj_list, input)).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Pathlist
  # -----------------------------------------------------------------------------

  it "Test Case 2 - DFS Pathlist" do

    input = [graph_adj_list, 'A', 'F']
    output = [["A", "B", "E", "F"], ["A", "C", "F"]]

    path_list = []
    for path in DepthFirstSearch::dfs_path_list(*input)
        path_list << path
    end
    expect(path_list).to eq(output)
  end
end
