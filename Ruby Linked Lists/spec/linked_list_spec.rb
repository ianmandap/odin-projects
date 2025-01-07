# frozen_string_literal: true

require './lib/linked_list'

describe LinkedList do
  let(:empty_list) { LinkedList.new }
  let(:list_1_element) do
    l = LinkedList.new
    l.append(0)
    l
  end
  let(:list_3_elements) do
    l = LinkedList.new
    l.append(0)
    l.append(1)
    l.append(2)
    l
  end

  describe '#append' do
    it 'Adds a new node at the end' do
      empty_list.append(2)
      expect(empty_list.head.value).to eql(2)
    end

    it 'Adds a new node at the end' do
      list_3_elements.append(10)
      expect(list_3_elements.tail.value).to eql(10)
    end
  end

  describe '#prepend' do
    it 'Adds a new node at the start' do
      empty_list.prepend(100)
      expect(empty_list.head.value).to eql(100)
    end

    it 'Adds a new node at the start' do
      list_3_elements.prepend(100)
      expect(list_3_elements.head.value).to eql(100)
    end
  end

  describe '#size' do
    it 'returns size if empty list' do
      expect(empty_list.size).to eql(0)
    end

    it 'returns size of list' do
      expect(list_3_elements.size).to eql(3)
    end
  end

  describe '#to_s' do
    it 'puts nil if empty list' do
      expect { empty_list.to_s }.to output(/nil/).to_stdout
    end

    it 'puts list sequence' do
      str =  '( 0 ) -> ( 1 ) -> ( 2 ) ->  nil'
      expect { puts(list_3_elements) }.to output(
        /#{Regexp.quote(str)}/
      ).to_stdout
    end
  end

  describe '#at' do
    it 'returns nil if empty list' do
      expect(empty_list.at(0)).to eql(nil)
    end

    it 'returns node at proper index' do
      expect(list_3_elements.at(0).value).to eql(0)
      expect(list_3_elements.at(1).value).to eql(1)
      expect(list_3_elements.at(2).value).to eql(2)
      expect(list_3_elements.at(3)).to eql(nil)
    end
  end

  describe '#contains?' do
    it 'returns false if list does not contain value' do
      expect(empty_list.contains?(100)).to eql(false)
    end

    it 'returns true if list contains value' do
      expect(list_3_elements.contains?(2)).to eql(true)
    end
  end

  describe '#find' do
    it 'returns nil if does not find value in list' do
      expect(empty_list.find(100)).to eql(nil)
    end

    it 'returns index if finds value in list' do
      expect(list_3_elements.find(1)).to eql(1)
    end
  end

  describe '#pop' do
    it 'does nothing with empty list' do
      expect(empty_list.pop).to eql(nil)
    end

    it 'removes head in list of 1' do
      expect(list_1_element.pop).to eql(nil)
      expect(list_1_element.size).to eql(0)
    end

    it 'removes last item in list of 3' do
      expect(list_3_elements.pop.value).to eql(2)
      expect(list_3_elements.size).to eql(2)
    end
  end

  describe '#insert_at' do
    it 'puts error with invalid index' do
      expect { list_3_elements.insert_at(10, 10) }.to output(
        /#{Regexp.quote('Error')}/
      ).to_stdout
    end

    it 'inserts head with empty list and idx 0' do
      empty_list.insert_at(0, 0)
      expect(empty_list.size).to eql(1)
      expect(empty_list.head.value).to eql(0)
    end

    it 'inserts tail with list when idx == size' do
      list_3_elements.insert_at(3, 3)
      expect(list_3_elements.size).to eql(4)
      expect(list_3_elements.tail.value).to eql(3)
    end

    it 'inserts in between with list' do
      list_3_elements.insert_at(0.5, 1)
      expect(list_3_elements.size).to eql(4)
      expect(list_3_elements.at(0).value).to eql(0)
      expect(list_3_elements.at(1).value).to eql(0.5)
      expect(list_3_elements.at(2).value).to eql(1)
    end

    describe '#remove_at' do
      it 'puts error with invalid index' do
        expect { list_3_elements.remove_at(10) }.to output(
          /#{Regexp.quote('Error')}/
        ).to_stdout
      end

      it 'remove head with 1 element list and idx 0' do
        list_1_element.remove_at(0)
        expect(list_1_element.size).to eql(0)
      end

      it 'removes tail with list when idx == size' do
        list_3_elements.remove_at(2)
        expect(list_3_elements.size).to eql(2)
        expect(list_3_elements.tail.value).to eql(1)
      end
    end

    it 'removes in between with list' do
      list_3_elements.remove_at(1)

      expect(list_3_elements.size).to eql(2)
      expect(list_3_elements.at(0).value).to eql(0)
      expect(list_3_elements.at(1).value).to eql(2)
    end
  end
end
