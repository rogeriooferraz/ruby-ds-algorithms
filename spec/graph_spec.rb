require "./lib/graph/graph"

describe Graph do

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
  graph = Graph.new(graph_adj_list)

  it "Test Case 1 - Graph" do
    output = {:A=>["B", "C"], :B=>["A", "D", "E"], :C=>["A", "F"], :D=>["B"], :E=>["B", "F"], :F=>["C", "E"]}
    expect(graph).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Traversal
  # -----------------------------------------------------------------------------

  it "Test Case 2 - Breadth-First Search (BFS) Traversal" do

    input = "A"
    output = ["A", "B", "C", "D", "E", "F"]

    expect(graph.bfsTraversal(input)).to eq(output)
  end

  it "Test Case 3 - Depth-First Search (DFS) Traversal" do

    input = "A"
    output = ["A", "B", "D", "E", "F", "C"]

    expect(graph.dfsTraversal(input)).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Pathlist
  # -----------------------------------------------------------------------------

  it "Test Case 4 - BFS Pathlist" do

    input = ['A', 'F']
    output = [["A", "C", "F"], ["A", "B", "E", "F"]]

    path_list = []
    for path in graph.bfsPathList(*input)
        path_list << path
    end
    expect(path_list).to eq(output)
  end

  it "Test Case 5 - DFS Pathlist" do

    input = ['A', 'F']
    output = [["A", "B", "E", "F"], ["A", "C", "F"]]

    path_list = []
    for path in graph.dfsPathList(*input)
        path_list << path
    end
    expect(path_list).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Shortest Path
  # -----------------------------------------------------------------------------

  it "Test Case 6 - BFS Shortest Path" do

    input = ['A', 'F']
    output = ["A", "C", "F"]

    expect(graph.bfsShortestPath(*input)).to eq(output)
  end

  it "Test Case 7 - DFS Shortest Path" do

    input = ['A', 'F']
    output = ["A", "C", "F"]

    expect(graph.bfsShortestPath(*input)).to eq(output)
  end
end
