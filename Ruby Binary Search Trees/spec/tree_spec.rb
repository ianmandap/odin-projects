# frozen_string_literal: true

require './lib/tree'

describe Tree do
  let(:array1) { [1, 2, 3, 4] }
  let(:tree1) { Tree.new(array1) }
  let(:array2) { [1, 2, 3, 4, 5, 6, 7] }
  let(:tree2) { Tree.new(array2) }
  let!(:out) { $stdout = StringIO.new }

  describe '#build_tree' do
    it 'builds a balanced tree and returns the level-0 root node' do
      expect(tree1.root.data).to eql(2)
      expect(tree2.root.data).to eql(4)
    end
  end

  describe '#pretty_print' do
    it 'pretty prints a balanced tree to stdout' do
      tree2.pretty_print
      out.rewind

      expect(out.gets).to eq("│       ┌── 7\n")
      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 5\n")
      expect(out.gets).to eq("└── 4\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end
  end

  describe '#insert' do
    it 'inserts node and maintains BST structure' do
      tree2.insert(4.5)
      tree2.pretty_print
      out.rewind

      expect(out.gets).to eq("│       ┌── 7\n")
      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 5\n")
      expect(out.gets).to eq("│   │       └── 4.5\n")
      expect(out.gets).to eq("└── 4\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end
  end

  describe '#delete' do
    it 'deletes leaf node and maintains BST structure' do
      tree2.insert(4.5)
      tree2.delete(7)
      tree2.pretty_print
      out.rewind

      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 5\n")
      expect(out.gets).to eq("│   │       └── 4.5\n")
      expect(out.gets).to eq("└── 4\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end

    it 'swaps node if it has one left child and maintains BST structure' do
      tree2.insert(4.5)
      tree2.delete(5)
      tree2.pretty_print
      out.rewind

      expect(out.gets).to eq("│       ┌── 7\n")
      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 4.5\n")
      expect(out.gets).to eq("└── 4\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end

    it 'swaps node with next value if it has one 2 child and maintains BST structure' do
      tree2.insert(4.5)
      tree2.delete(4)
      tree2.pretty_print
      out.rewind

      expect(out.gets).to eq("│       ┌── 7\n")
      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 5\n")
      expect(out.gets).to eq("└── 4.5\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end

    describe '#level_order' do
      it 'returns array of nodes in level order of BST' do
        expect(tree1.level_order(tree1.root)).to eql([2, 1, 3, 4])
        expect(tree2.level_order(tree2.root)).to eql([4, 2, 6, 1, 3, 5, 7])
      end
    end

    describe '#preorder' do
      it 'returns array of nodes in preorder of BST' do
        expect(tree1.preorder(tree1.root)).to eql([2, 1, 3, 4])
        expect(tree2.preorder(tree2.root)).to eql([4, 2, 1, 3, 6, 5, 7])
      end
    end

    describe '#inorder' do
      it 'returns array of nodes in inorder of BST' do
        expect(tree1.inorder(tree1.root)).to eql(array1)
        expect(tree2.inorder(tree2.root)).to eql(array2)
      end
    end

    describe '#postorder' do
      it 'returns array of nodes in postorder of BST' do
        expect(tree1.postorder(tree1.root)).to eql([1, 4, 3, 2])
        expect(tree2.postorder(tree2.root)).to eql([1, 3, 2, 5, 7, 6, 4])
      end
    end
  end
end
