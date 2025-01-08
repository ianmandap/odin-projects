# frozen_string_literal: true

require './lib/tree'

describe Tree do
  let(:array1) { [1, 2, 3] }
  let(:tree1) { Tree.new(array1) }
  let(:array2) { [1, 2, 3, 4, 5, 6, 7] }
  let(:tree2) { Tree.new(array2) }

  describe '#build_tree' do
    it 'builds a balanced tree and returns the level-0 root node' do
      expect(tree1.root.data).to eql(2)
      expect(tree2.root.data).to eql(4)
    end
  end

  describe '#pretty_print' do
    it 'pretty prints a balanced tree to stdout' do
      $stdout = StringIO.new
      tree2.pretty_print
      $stdout.rewind

      expect($stdout.gets).to eq("│       ┌── 7\n")
      expect($stdout.gets).to eq("│   ┌── 6\n")
      expect($stdout.gets).to eq("│   │   └── 5\n")
      expect($stdout.gets).to eq("└── 4\n")
      expect($stdout.gets).to eq("    │   ┌── 3\n")
      expect($stdout.gets).to eq("    └── 2\n")
      expect($stdout.gets).to eq("        └── 1\n")
    end
  end
end
