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

require_relative "./canonic_queue_node"

class CanonicQueue

  attr_reader :front, :rear

  def initialize
    @front = nil
    @rear = nil
  end

  def enqueue(data)
    temp = CanonicQueueNode.new(data)
    if @rear
      @rear.next = temp
    else
      @front = temp
    end
    @rear = temp
  end

  def dequeue
    if @front
      data = @front.container
      @front = @front.next
      if empty?
        @rear = nil
      end
      return data
    end
  end

  def empty?
    @front == nil
  end

  def to_s
    output = ""
    p = @front
    while p
      output += str(p.container) + " "
      p = p.next
    end
    output
  end

  alias enq enqueue
  alias deq dequeue
end
