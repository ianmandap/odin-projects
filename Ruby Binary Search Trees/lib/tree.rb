# frozen_string_literal: true

require_relative 'node'
require 'byebug'

# Binary Tree Data Structure
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array
    @root = build_tree(array.sort.uniq)
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

  def insert; end
  def delete; end
  def find; end
  def level_order; end
  def preorder; end
  def inorder; end
  def postorder; end
  def height; end
  def depth; end
  def balanced?; end
  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
