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

  # builds a balanced binary tree
  def build_tree(arr, start = 0, last = arr.length - 1)
    return 'Array is unsorted' if arr.sort != arr
    return nil if start > last

    mid = (start + last) / 2
    root_node = Node.new(arr[mid])
    root_node.left = build_tree(arr, start, mid - 1)
    root_node.right = build_tree(arr, mid + 1, last)

    @root = root_node
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

  def find(val)
    return root if root.data == val

    node = root
    until node.data == val
      return nil if node.left.nil? && node.right.nil?

      node = traverse(val, node)
    end

    node
  end

  # returns array of nodes or passes each node if block is provided
  def level_order(node = root)
    return if node.nil?

    block_given? ? (yield node) : (arr = [node])
    queue = [node.left, node.right].compact

    until queue.empty?
      next_node = queue.shift
      block_given? ? (yield next_node) : (arr << next_node)
      queue << next_node.left unless next_node.left.nil?
      queue << next_node.right unless next_node.right.nil?
    end

    arr
  end

  # root-left-right
  # returns array of nodes or passes each node if block is provided
  def preorder(node = root, result = [], &block)
    return if node.nil?

    block_given? ? (yield node) : (result << node)
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result
  end

  # left-root-right
  # returns array of nodes or passes each node if block is provided
  def inorder(node = root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    block_given? ? (yield node) : (result << node)
    inorder(node.right, result, &block)

    result
  end

  # left-right-root
  # returns array of nodes or passes each node if block is provided
  def postorder(node = root, result = [], &block)
    return if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    block_given? ? (yield node) : (result << node)

    result
  end

  # no. of edges from node to a leaf
  def height(node)
    return -1 if node.nil?

    left_subtree = height(node.left)
    right_subtree = height(node.right)
    1 + [left_subtree, right_subtree].max
  end

  # no. of edges from node to root
  def depth(node)
    return 0 if node == root

    count = 0
    current = root
    until current == node
      count += 1
      current = traverse(node.data, current)
    end

    count
  end

  def balanced?
    bool = true

    level_order do |node|
      diff = height(node.left) - height(node.right)
      bool = false if diff.abs > 1
    end

    bool
  end

  def rebalance
    return if balanced?

    sorted_arr = inorder.map(&:data)
    build_tree(sorted_arr)
    'completed: rebalanced tree'
  end

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

  # Utility function
  # Compare val with node and return child node
  def traverse(val, node)
    if val == node.data
      node
    elsif val < node.data
      node.left
    else
      node.right
    end
  end
end
