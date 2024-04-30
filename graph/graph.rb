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


require_relative "../ds/linked/queue"
require_relative "../ds/linked/stack"


class Graph

    def initialize(graph_adj_list = nil)
        @adj_list = {}
        if graph_adj_list
            graph_adj_list.each do |inode, adj_list|
                addVertex(inode)
                adj_list.each do |jnode|
                    addEdge(inode, jnode)
                end
            end
        end
    end

    def to_s
        @adj_list.to_s
    end

    def addEdge(vertex, adj_vertex)
        begin
            @adj_list[vertex.to_sym].append(adj_vertex)
        rescue
            puts "Error: vertex #{vertex} is not defined"
        end
    end

    def addVertex(vertex)
        if !@adj_list.include?(vertex)
            @adj_list[vertex] = []
        end
    end

    def bfsTraversal(origin)
        queue = CanonicalQueue.new
        queue.enqueue(origin)
        visited = [origin]
        while !queue.empty?
            inode = queue.dequeue
            @adj_list[inode.to_sym].each do |jnode|
                if !visited.include?(jnode)
                    queue.enqueue(jnode)
                    visited.append(jnode)
                end
            end
        end
        visited
    end

    def bfsPathList(origin, destination)
        Enumerator.new do |gen|
            queue = CanonicalQueue.new
            queue.enqueue([origin, [origin]])
            while !queue.empty?
                inode, path = queue.dequeue
                @adj_list[inode.to_sym].each do |jnode|
                    if !path.include?(jnode)
                        if jnode == destination
                            gen.yield path + [jnode]
                        else
                            queue.enqueue([jnode, path + [jnode]])
                        end
                    end
                end
            end
        end
    end

    def bfsShortestPath(origin, destination)
        begin
            bfsPathList(origin, destination).next
        rescue StopIteration
            nil
        end
    end

    def dfsTraversal(origin)
        stack = CanonicalStack.new
        stack.push(origin)
        visited = []
        while !stack.empty?
            inode = stack.pop
            if !visited.include?(inode)
                visited.append(inode)
            end
            @adj_list[inode.to_sym].reverse.each do |jnode|
                if !visited.include?(jnode)
                    stack.push(jnode)
                end
            end
        end
        visited
    end

    def dfsPathList(origin, destination)
        Enumerator.new do |gen|
            stack = CanonicalStack.new
            stack.push([origin, [origin]])
            while !stack.empty?
                inode, path = stack.pop
                @adj_list[inode.to_sym].reverse.each do |jnode|
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
end
