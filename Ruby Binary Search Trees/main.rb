# frozen_string_literal: true

require_relative 'lib/tree'

# Create a binary search tree from an array of random numbers
arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)

# Confirm that the tree is balanced by calling #balanced?
p tree.balanced?

# Print out all elements in level, pre, post, and in order
p tree.level_order.map(&:data)
p tree.preorder.map(&:data)
p tree.inorder.map(&:data)
p tree.postorder.map(&:data)

# Unbalance the tree by adding several numbers > 100
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)

# Confirm that the tree is unbalanced by calling #balanced?
p tree.balanced?

# Balance the tree by calling #rebalance
p tree.rebalance

# Confirm that the tree is balanced by calling #balanced?
p tree.balanced?

# Print out all elements in level, pre, post, and in order.
p tree.level_order.map(&:data)
p tree.preorder.map(&:data)
p tree.inorder.map(&:data)
p tree.postorder.map(&:data)
