# frozen_string_literal: true

RSpec.describe LineItem do
  describe '#initialize' do
    it 'calculates tax and total for a basic item' do
      item = Item.new('music CD', 14.99)
      line_item = LineItem.new(item)

      expect(line_item.tax).to eq(1.50)
      expect(line_item.total).to eq(16.49)
    end

    it 'calculates tax and total for an imported item' do
      item = Item.new('imported bottle of perfume', 47.50)
      line_item = LineItem.new(item)

      expect(line_item.tax).to eq(7.15)
      expect(line_item.total).to eq(54.65)
    end
  end

  describe '#to_s' do
    it 'formats the line item correctly' do
      item = Item.new('music CD', 14.99)
      line_item = LineItem.new(item)

      expect(line_item.to_s).to eq('1 music CD: 16.49')
    end

    it 'formats multiple quantities correctly' do
      item = Item.new('book', 12.49, quantity: 2)
      line_item = LineItem.new(item)

      expect(line_item.to_s).to eq('2 book: 24.98')
    end
  end
end
