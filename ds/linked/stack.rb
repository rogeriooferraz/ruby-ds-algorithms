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


class CanonicalStack

    def initialize
        @top = nil
    end

    def push(data)
        temp = Node.new(data)
        temp.next = @top
        @top = temp
    end

    def pop
        if @top
            data = @top.container
            @top = @top.next
            return data
        end
    end

    def empty?
        return @top == nil
    end

    def to_s
        output = ""
        p = @top 
        while p
            output += str(p.container) + " "
            p = p.next 
        end
        return output
    end
end


class Node

    attr_reader :container
    attr_accessor :next

    def initialize(data)
        @container = data
        @next = nil
    end

    def to_s
        @container.to_s
    end

    def ==(other)
        self.to_s == other.to_s
    end
end
