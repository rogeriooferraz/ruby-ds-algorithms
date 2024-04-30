=begin
Copyright (c) 2024 Rogerio O. Ferraz <rogerio.o.ferraz@gmail.com>

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
=end


require_relative "graph"


def bfs_traversal(adj_list, origin)
  visited = [origin]
  queue = Queue.new
  queue.enq(origin)
  while !queue.empty?
    inode = queue.deq
    adj_list[inode.to_sym].each do |jnode|
      if !visited.include?(jnode)
        visited.append(jnode)
        queue.enq(jnode)
      end
    end
  end
  visited
end


def bfs_path_list(adj_list, origin, destination)
  Enumerator.new do |gen|
    queue = Queue.new
    queue.enq([origin, [origin]])
    while !queue.empty?
      (inode, path) = queue.deq
      adj_list[inode.to_sym].each do |jnode|
        if !path.include?(jnode)
          if jnode == destination
            gen.yield path + [jnode]
          else
            queue.enq([jnode, path + [jnode]])
          end
        end
      end
    end
  end
end

def bfs_shortest_path(adj_list, origin, destination)
  begin
    bfs_path_list(adj_list, origin, destination).next
  rescue StopIteration
    ""
  end
end

# -----------------------------------------------------------------------------
# Graph
# -----------------------------------------------------------------------------

puts "Graph:"

graph_adj_list = {
  "A": ["B", "C"],
  "B": ["A", "D", "E"],
  "C": ["A", "F"],
  "D": ["B"],
  "E": ["B", "F"],
  "F": ["C", "E"]
}

g = Graph.new(graph_adj_list)
puts "\t#{g}"

# -----------------------------------------------------------------------------
# Traversal using Breadth-First Search (BFS)
# -----------------------------------------------------------------------------

puts "\nTraversal using Breadth-First Search (BFS):\n\n"

puts "using class method\t: #{g.bfsTraversal("A")}"
puts "using function\t\t: #{bfs_traversal(graph_adj_list, "A")}\n"

# -----------------------------------------------------------------------------
# Path List
# -----------------------------------------------------------------------------

puts "\nPath List:\n\n"

puts "using class method:"
for path_list in g.bfsPathList('A', 'F')
    puts "\t#{path_list}"
end

puts "\nusing function:"
bfs_path_list(graph_adj_list, 'A', 'F').each do |path_list|
  puts "\t#{path_list}"
end

# -----------------------------------------------------------------------------
# Shortest Path
# -----------------------------------------------------------------------------

puts "\nShortest Path:\n\n"

puts "using class method\t: #{g.bfsShortestPath('A', 'F')}"
puts "using function\t\t: #{bfs_shortest_path(graph_adj_list, 'A', 'F')}"

# -----------------------------------------------------------------------------
# Output
# -----------------------------------------------------------------------------

# Graph:
#     {:A=>["B", "C"], :B=>["A", "D", "E"], :C=>["A", "F"], :D=>["B"], :E=>["B", "F"], :F=>["C", "E"]}

# Traversal using Breadth-First Search (BFS):

# using class method    : ["A", "B", "C", "D", "E", "F"]
# using function        : ["A", "B", "C", "D", "E", "F"]

# Path List:

# using class method:
#     ["A", "C", "F"]
#     ["A", "B", "E", "F"]

# using function:
#     ["A", "C", "F"]
#     ["A", "B", "E", "F"]

# Shortest Path:

# using class method    : ["A", "C", "F"]
# using function        : ["A", "C", "F"]
