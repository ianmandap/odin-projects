# frozen_string_literal: true

require_relative 'lib/tree'

# Create a binary search tree from an array of random numbers
arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)
puts tree.pretty_print

# Confirm that the tree is balanced by calling #balanced?
puts tree.balanced?

# Print out all elements in level, pre, post, and in order
puts tree.level_order
puts tree.preorder
puts tree.inorder
puts tree.postorder

# Unbalance the tree by adding several numbers > 100

# Confirm that the tree is unbalanced by calling #balanced?
puts tree.balanced?

# Balance the tree by calling #rebalance
puts tree.rebalance

# Confirm that the tree is balanced by calling #balanced?
puts tree.balanced?

# Print out all elements in level, pre, post, and in order.
puts tree.level_order
puts tree.preorder
puts tree.inorder
puts tree.postorder
