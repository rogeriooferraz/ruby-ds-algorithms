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


def dfs_traversal(adj_list, orignode)
    visited = []
    stack = [orignode]
    while !stack.empty?
        inode = stack.pop
        if !visited.include?(inode)
            visited.append(inode)
        end
        adj_list[inode.to_sym].reverse.each do |jnode|
            if !visited.include?(jnode)
                stack.push(jnode)
            end
        end
    end
    visited
end


def dfs_path_list(adj_list, origin, destination)
    Enumerator.new do |gen|
        stack = [[origin, [origin]]]
        while !stack.empty?
            inode, path = stack.pop
            adj_list[inode.to_sym].reverse.each do |jnode|
                if !path.include?(jnode)
                    if jnode == destination
                        gen.yield path + [jnode]
                    else
                        stack.push([jnode, path + [jnode]])
                    end
                end
            end
        end
    end
end


# -----------------------------------------------------------------------------
# Graph
# -----------------------------------------------------------------------------

puts "Graph:"

graph_adj_list = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

g = Graph.new(graph_adj_list)
puts "\t#{g}"

# -----------------------------------------------------------------------------
# Traversal using Depth-First Search (DFS)
# -----------------------------------------------------------------------------

puts "\nTraversal using Depth-First Search (DFS):\n\n"

puts "using class method\t: #{g.dfsTraversal("A")}"
puts "using function\t\t: #{dfs_traversal(graph_adj_list, "A")}\n"

# -----------------------------------------------------------------------------
# Path List
# -----------------------------------------------------------------------------

puts "\nPath List:\n\n"

puts "using class method:"
g.dfsPathList('A', 'F').each do |path_list|
    puts "\t#{path_list}"
end

puts "\nusing function:"
dfs_path_list(graph_adj_list, 'A', 'F').each do |path_list|
    puts "\t#{path_list}"
end

# -----------------------------------------------------------------------------
# Output
# -----------------------------------------------------------------------------

# Graph:
#     {:A=>["B", "C"], :B=>["A", "D", "E"], :C=>["A", "F"], :D=>["B"], :E=>["B", "F"], :F=>["C", "E"]}

# Traversal using Depth-First Search (DFS):

# using class method    : ["A", "B", "D", "E", "F", "C"]
# using function        : ["A", "B", "D", "E", "F", "C"]

# Path List:

# using class method:
#     ["A", "B", "E", "F"]
#     ["A", "C", "F"]

# using function:
#     ["A", "B", "E", "F"]
#     ["A", "C", "F"]
