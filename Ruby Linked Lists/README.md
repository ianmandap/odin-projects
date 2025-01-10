## Learnings
Ruby does not have this data structure supported. Here, I implemented a `LinkedList` class in Ruby following the Assignment metric using Test Driven Development (RSpecs) 

**Linked Lists**
- are linear collections of data elements called nodes that "point" to the next node by means of a pointer
- each node holds a single element of data and a pointer to the next node in the list.
- parts: **head node** is the first node; **tail node** is the last node
- e.g. `[ NODE(head) ] -> [ NODE ] -> [ NODE(tail) ] -> nil`

```
### Assignment

You will need two classes:

1. `LinkedList` class, which will represent the full list.
1. `Node` class, containing two instance variables, `#value` and `#next_node`, set both as `nil` by default.

Build the following methods in your linked list class:

1. `#append(value)` adds a new node containing `value` to the end of the list
1. `#prepend(value)` adds a new node containing `value` to the start of the list
1. `#size` returns the total number of nodes in the list
1. `#head` returns the first node in the list
1. `#tail` returns the last node in the list
1. `#at(index)` returns the node at the given `index`
1. `#pop` removes the last element from the list
1. `#contains?(value)` returns true if the passed in value is in the list and otherwise returns false.
1. `#find(value)` returns the index of the node containing value, or nil if not found.
1. `#to_s` represent your LinkedList objects as strings, so you can print them out and preview them in the console.
    The format should be: `( value ) -> ( value ) -> ( value ) -> nil`

#### Extra credit

1. `#insert_at(value, index)` that inserts a new node with the provided `value` at the given `index`.
1. `#remove_at(index)` that removes the node at the given `index`.

**Extra Credit Tip:** When you insert or remove a node, consider how it will affect the existing nodes. Some of the nodes will need their `#next_node` link updated.

#### Test it out

Let's test out the Linked List you made!

1. Create a `main.rb` file and make sure it requires the file containing `LinkedList`. This is where we'll test the list.

1. Create an instance of `LinkedList` and populate it with nodes:

   ```ruby
   list = LinkedList.new

   list.append('dog')
   list.append('cat')
   list.append('parrot')
   list.append('hamster')
   list.append('snake')
   list.append('turtle')
   ```

1. Add `puts list` to the end of the file and run it. Because of the naming, this should use the `#to_s` method you wrote earlier.

1. If everything is working, the output should be `( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> ( snake ) -> ( turtle ) -> nil`. Feel free to use different values to test if you like.
```