# frozen_string_literal: true

require_relative 'node'
require 'byebug'

# Binary Tree Data Structure
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array
    @root = build_tree(data.sort.uniq)
  end

  def build_tree(arr, start = 0, last = arr.length - 1)
    return 'Array is unsorted' if arr.sort != arr
    return nil if start > last

    mid = (start + last) / 2
    root_node = Node.new(arr[mid])
    root_node.left = build_tree(arr, start, mid - 1)
    root_node.right = build_tree(arr, mid + 1, last)

    root_node
  end

  def insert(val, root = @root)
    return Node.new(val) if root.nil?

    if val == root.data
      return root
    elsif val < root.data
      root.left = insert(val, root.left)
    else
      root.right = insert(val, root.right)
    end

    root
  end

  def delete(val, root = @root)
    return root if root.nil?

    # Traverse subtrees
    if val < root.data
      root.left = delete(val, root.left)
    elsif val > root.data
      root.right = delete(val, root.right)
    else
      # root matches with val
      # Case 1: root has no children or only right child
      return root.right if root.left.nil?

      # Case 2: root only has left child
      return root.left if root.right.nil?

      # Case 3: both children present
      successor = get_successor(root)
      root.data = successor.data
      root.right = delete(successor.data, root.right)
    end

    root
  end

  def find; end

  def level_order(node = root)
    return if node.nil?

    arr = [node.data]
    queue = [node.left, node.right].compact

    until queue.empty?
      n = queue.shift
      arr << n.data
      queue << n.left unless n.left.nil?
      queue << n.right unless n.right.nil?
    end

    arr
  end

  # root-left-right
  def preorder(node = root, result = [])
    return if node.nil?

    result << node.data
    preorder(node.left, result)
    preorder(node.right, result)

    result
  end

  # left-root-right
  def inorder(node = root, result = [])
    return if node.nil?

    inorder(node.left, result)
    result << node.data
    inorder(node.right, result)

    result
  end

  # left-right-root
  def postorder(node = root, result = [])
    return if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    result << node.data

    result
  end

  def height; end
  def depth; end
  def balanced?; end
  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  # Utility function for deleting a node with 2 children
  # Traverse node's right subtree, and look for farthest left value
  def get_successor(current)
    current = current.right

    current = current.left until current.left.nil?

    current
  end
end
