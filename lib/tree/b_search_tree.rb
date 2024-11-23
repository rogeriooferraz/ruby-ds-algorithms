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

require_relative "./b_search_tree_node"

class BSearchTree

  attr_reader :root

  def initialize(arr = nil)
    if arr
      @root = to_bst(arr)
    else
      @root = nil
    end
  end

  def to_bst(arr)
    _insert_array(arr.sort, 0, arr.size-1)
  end

  def bsearch(key)
    node = @root
    while node
      if key < node.key
        node = node.lchild
      elsif key > node.key
        node = node.rchild
      else
        return node
      end
    end
    nil
  end

  alias at bsearch

  def to_a
    _to_array
  end

  def slice(head, tail = head, node = @root, arr = [])
    return if !node

    if node.key < head
      slice(head, tail, node.rchild, arr)
    elsif node.key == head
      arr << node.key
      if tail > head
        slice(head, tail, node.rchild, arr)
      end
    elsif node.key == tail
      slice(head, tail, node.lchild, arr)
      arr << node.key
    elsif node.key > tail
      slice(head, tail, node.lchild, arr)
    else
      slice(head, tail, node.lchild, arr)
      arr << node.key
      slice(head, tail, node.rchild, arr)
    end

    BSearchTree.new(arr) if node == @root
  end

  alias [] slice

  def min
    return if empty?

    node = @root
    while node.lchild
      node = node.lchild
    end

    node
  end

  def max
    return if empty?

    node = @root
    while node.rchild
      node = node.rchild
    end

    node
  end

  def insert(key)
    node = @root
    parent = nil

    while node
      parent = node
      if key < node.key
        node = node.lchild
      elsif key > node.key
        node = node.rchild
      else
        return
      end
    end

    new_node = BSearchTreeNode.new(key)

    if !parent
      @root = new_node
    elsif key < parent.key
      parent.lchild = new_node
    else
      parent.rchild = new_node
    end
  end

  def delete(key)
    node = @root
    parent = nil

    while node
      if key == node.key
        break
      end
      parent = node
      if key < node.key
        node = node.lchild
      else
        node = node.rchild
      end
    end

    if !node
      return
    end

    if node.lchild && node.rchild
      succ_parent = node
      successor = node.rchild

      while successor.lchild
        succ_parent = successor
        successor = successor.lchild
      end
      node.key = successor.key
      node = successor
      parent = succ_parent
    end

    if node.lchild
      child = node.lchild
    else
      child = node.rchild
    end

    if !parent
      @root = child
    elsif node == parent.lchild
      parent.lchild = child
    else
      parent.rchild = child
    end
  end

  def empty?
    @root == nil
  end

  def to_s
    to_a.to_s
  end

  def ==(other)
    self.to_s == other.to_s
  end

  private

  def _insert_array(arr, head, tail)
    return nil if tail < head
      
    mid = (head+tail)/2
    new_node = BSearchTreeNode.new(arr[mid])
    new_node.lchild = _insert_array(arr, head, mid-1)
    new_node.rchild = _insert_array(arr, mid+1, tail)

    new_node
  end

  def _to_array(node = @root, arr = [])
    return if !node

    _to_array(node.lchild, arr)
    arr << node.key
    _to_array(node.rchild, arr)

    arr if node == @root
  end
end
