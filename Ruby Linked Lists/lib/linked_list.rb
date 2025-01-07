# frozen_string_literal: true

require_relative 'node'
require 'byebug'

# Data structure containing a series of nodes
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value, nil)

    if @head.nil?
      @head = new_node
    elsif @tail.nil?
      @head.next_node = new_node
      @tail = new_node
    else
      old_tail = @tail
      old_tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    @tail = @head if size == 1
    @head = Node.new(value, @head)
  end

  def size
    n = 0
    current = @head
    return n if @head.nil?

    n = 1
    until current.next_node.nil?
      n += 1
      current = current.next_node
    end

    n
  end

  def at(idx)
    current_node = @head
    current_idx = 0

    until current_node&.next_node.nil? || idx == current_idx
      current_node = current_node.next_node
      current_idx += 1
    end

    return current_node if idx == current_idx

    nil
  end

  def contains?(value)
    bool = false
    current_node = @head

    until bool || current_node.nil?
      if current_node&.value == value
        bool = true
        break
      end

      current_node = current_node&.next_node
    end

    bool
  end

  def find(value)
    found = false
    current_node = @head
    current_idx = 0

    until found || current_node.nil?
      if current_node&.value == value
        found = true
        break
      end

      current_node = current_node&.next_node
      current_idx += 1
    end

    found ? current_idx : nil
  end

  def to_s
    return puts 'nil' if @head.nil?

    string = "( #{@head.value} ) -> "

    unless @tail.nil?
      current = @head
      until current.next_node.nil?
        current = current.next_node
        string += "( #{current.value} ) -> "
      end
    end

    puts "#{string} nil"
  end

  def pop
    @head = nil if @tail.nil?
    return if @head.nil? || @tail.nil?

    removed_node = at(size - 1)
    prev_node = at(size - 2)
    prev_node.next_node = nil
    @tail = prev_node

    removed_node
  end

  def insert_at(value, idx)
    return puts 'Error: Invalid chosen index' if idx > size
    return prepend(value) if idx.zero?
    return append(value) if idx == size

    node_at_idx = at(idx)
    next_node = at(idx + 1)
    node_at_idx.next_node = next_node

    new_node = Node.new(value, node_at_idx)
    prev_node = at(idx - 1)
    prev_node.next_node = new_node
  end

  def remove_at(idx)
    return puts 'Error: Invalid chosen index' if size.zero? || (idx - 1) > size
    return pop if idx.zero? || at(idx).next_node.nil?

    prev_node = at(idx - 1)
    removed_node = at(idx)

    prev_node.next_node = removed_node.next_node
  end
end
