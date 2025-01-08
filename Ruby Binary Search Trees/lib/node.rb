# frozen_string_literal: true

# Data Structure to hold a value and 2 children
class Node
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
