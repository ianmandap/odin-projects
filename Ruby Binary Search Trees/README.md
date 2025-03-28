## Learnings
Here, I implemented a `Tree` class in Ruby following the Assignment metric using Test Driven Development (RSpecs). 

**Balanced Binary Search Trees (BST)**
- a binary tree in which height of left and right subtree of any node differ by not more than 1
- performance-wise good as they provide `O log(n)` time for search, insert and delete
- created from a sorted array

**[Capturing multi-line console output in Ruby's RSpec testing interface](https://blog.petefowler.dev/capturing-multi-line-console-output-in-rubys-rspec-testing-interface)**
- `Tree#pretty_print` outputs a tree structure to the console. To streamline RSpec testing, we assign `$stdout` to a `StringIO` object so any output is captured. We can then use `$stdout.rewind` and sequentially use `$stdout.gets` to check line by line against expected output.
- since reassigning `$stdout = StringIO` pollutes the global namespace, an `after(:each) { $stdout = STDOUT }` was put to restore test defaults. This allows the normal use of `byebug` and `puts` operations without their print execution going into `StringIO`.

**Blocks and `yield`**
- Implementation requirements for `#level_order`, `#preorder`, `#inorder`, and `#postorder` methods required for the traversed nodes to be yielded to a block, if provided, and to return an array of values if not provided. 
- In method definitions, if put as the last argument, I learned the keyword `&` explicitly captures blocks and can then be yielded onto inside the method body. This allows for more flexible and powerful use as exemplified by the `#balanced?` method

```
### Assignment

Build a Node class. It should have an attribute for the data it stores as well as its left and right children. As a bonus, try including the Comparable module and compare nodes using their data attribute.

Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute, which uses the return value of #build_tree which you’ll write next.

Write a #build_tree method which takes an array of data (e.g., [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-0 root node.

Tip: If you would like to visualize your binary search tree, here is a #pretty_print method that a student wrote and shared on Discord:

 def pretty_print(node = @root, prefix = '', is_left = true)
   pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
   puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
   pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
 end

    Write an #insert and #delete method which accepts a value to insert/delete. You’ll have to deal with several cases for delete, such as when a node has children or not. If you need additional resources, check out these two articles on inserting and deleting, or this video on BST inserting/removing with several visual examples.

    You may be tempted to implement these methods using the original input array, but it’s important for the efficiency of these operations that you don’t do this. If we refer back to the Big O Cheatsheet, we’ll see that binary search trees can insert/delete in O(log n) time, which is a significant performance boost over arrays for the same operations. To get this added efficiency, your implementation of these methods should traverse the tree and manipulate the nodes and their connections.

    Write a #find method which accepts a value and returns the node with the given value.

    Write a #level_order method which accepts a block. This method should traverse the tree in breadth-first level order and yield each node to the provided block. This method can be implemented using either iteration or recursion (try implementing both!). The method should return an array of values if no block is given. Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse, and to add new ones to the list (video on level order traversal).

    Write #inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.

    Write a #height method that accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

    Write a #depth method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

    Write a #balanced? method that checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.

    Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.

Tie it all together

Write a driver script that does the following:

    Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
    Confirm that the tree is balanced by calling #balanced?
    Print out all elements in level, pre, post, and in order
    Unbalance the tree by adding several numbers > 100
    Confirm that the tree is unbalanced by calling #balanced?
    Balance the tree by calling #rebalance
    Confirm that the tree is balanced by calling #balanced?
    Print out all elements in level, pre, post, and in order.
```