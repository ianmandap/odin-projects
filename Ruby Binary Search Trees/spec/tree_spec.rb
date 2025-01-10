# frozen_string_literal: true

require './lib/tree'

describe Tree do
  let(:array1) { [1, 2, 3, 4] }
  let(:tree1) { Tree.new(array1) }
  let(:array2) { [1, 2, 3, 4, 5, 6, 7] }
  let(:tree2) { Tree.new(array2) }

  def setup_pretty_print(tree)
    $stdout = StringIO.new
    tree.pretty_print
    out = $stdout
    out.rewind
    out
  end

  after(:each) do
    # since #setup_pretty_print will polute the global namespace
    $stdout = STDOUT
  end

  describe '#build_tree' do
    it 'builds a balanced tree and returns the level-0 root node' do
      expect(tree1.root.data).to eql(2)
      expect(tree2.root.data).to eql(4)
    end
  end

  describe '#pretty_print' do
    it 'pretty prints a balanced tree to stdout' do
      out = setup_pretty_print(tree2)

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
      out = setup_pretty_print(tree2)

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
      out = setup_pretty_print(tree2)

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
      out = setup_pretty_print(tree2)

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
      out = setup_pretty_print(tree2)

      expect(out.gets).to eq("│       ┌── 7\n")
      expect(out.gets).to eq("│   ┌── 6\n")
      expect(out.gets).to eq("│   │   └── 5\n")
      expect(out.gets).to eq("└── 4.5\n")
      expect(out.gets).to eq("    │   ┌── 3\n")
      expect(out.gets).to eq("    └── 2\n")
      expect(out.gets).to eq("        └── 1\n")
    end
  end

  describe '#level_order' do
    context 'with a block provided' do
      it 'yields each node to the block' do
        nodes_arr = tree1.level_order
        expect { |b| tree1.level_order(&b) }.to yield_successive_args(*nodes_arr)
      end
    end

    context 'with no block provided' do
      it 'returns array of nodes in level order of BST' do
        expect(tree1.level_order(tree1.root).map(&:data)).to eql([2, 1, 3, 4])
        expect(tree2.level_order(tree2.root).map(&:data)).to eql([4, 2, 6, 1, 3, 5, 7])
      end
    end
  end

  describe '#preorder' do
    context 'with a block provided' do
      it 'yields each node to the block' do
        nodes_arr = tree1.preorder
        expect { |b| tree1.preorder(&b) }.to yield_successive_args(*nodes_arr)
      end
    end

    context 'with no block provided' do
      it 'returns array of nodes in preorder of BST' do
        expect(tree1.preorder(tree1.root).map(&:data)).to eql([2, 1, 3, 4])
        expect(tree2.preorder(tree2.root).map(&:data)).to eql([4, 2, 1, 3, 6, 5, 7])
      end
    end
  end

  describe '#inorder' do
    context 'with a block provided' do
      it 'yields each node to the block' do
        nodes_arr = tree1.inorder
        expect { |b| tree1.inorder(&b) }.to yield_successive_args(*nodes_arr)
      end
    end

    context 'with no block provided' do
      it 'returns array of nodes in inorder of BST' do
        expect(tree1.inorder(tree1.root).map(&:data)).to eql(array1)
        expect(tree2.inorder(tree2.root).map(&:data)).to eql(array2)
      end
    end
  end

  describe '#postorder' do
    context 'with a block provided' do
      it 'yields each node to the block' do
        nodes_arr = tree1.postorder
        expect { |b| tree1.postorder(&b) }.to yield_successive_args(*nodes_arr)
      end
    end

    context 'with no block provided' do
      it 'returns array of nodes in postorder of BST' do
        expect(tree1.postorder(tree1.root).map(&:data)).to eql([1, 4, 3, 2])
        expect(tree2.postorder(tree2.root).map(&:data)).to eql([1, 3, 2, 5, 7, 6, 4])
      end
    end
  end

  describe '#find' do
    it 'returns node with given value' do
      expect(tree2.find(2)).to eq(tree2.root.left)
      expect(tree2.find(7)).to eq(tree2.root.right.right)
      expect(tree2.find(100)).to eq(nil)
    end
  end

  describe '#depth' do
    it 'returns depth of given node' do
      tree2.insert(4.5)

      node2 = tree2.find(2)
      expect(tree2.depth(node2)).to eq(1)

      node1 = tree2.find(4.5)
      expect(tree2.depth(node1)).to eq(3)
    end
  end

  describe '#height' do
    it 'returns height of given node' do
      tree2.insert(4.5)

      node2 = tree2.find(4)
      expect(tree2.height(node2)).to eq(3)

      node2 = tree2.find(2)
      expect(tree2.height(node2)).to eq(1)

      node1 = tree2.find(4.5)
      expect(tree2.height(node1)).to eq(0)
    end
  end

  describe '#balanced?' do
    it 'returns true if tree is balanced' do
      expect(tree1.balanced?).to eq(true)
    end

    it 'returns false if tree is unbalanced' do
      tree1.insert(2.22)
      tree1.insert(2.33)

      expect(tree1.balanced?).to eq(false)
    end
  end

  describe '#rebalance' do
    it 'does nothing if already balanced' do
      tree_before = tree1
      tree1.rebalance
      expect(tree_before).to eq(tree1)
    end

    it 'rebuilds nodes of an unbalanced tree' do
      tree1.insert(2.22)
      tree1.insert(2.33)
      expect(tree1.balanced?).to eq(false)

      tree1.rebalance
      expect(tree1.balanced?).to eq(true)
      expect(tree1.inorder.size).to eq(6)
    end
  end
end
