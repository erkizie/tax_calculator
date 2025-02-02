# frozen_string_literal: true

RSpec.describe Item do
  describe '#initialize' do
    it 'creates a valid item' do
      item = Item.new('book', 12.49)
      expect(item.name).to eq('book')
      expect(item.price).to eq(12.49)
      expect(item.quantity).to eq(1)
    end

    it 'identifies exempt items' do
      book = Item.new('book', 12.49)
      cd = Item.new('music CD', 14.99)
      chocolate = Item.new('chocolate bar', 0.85)
      pills = Item.new('headache pills', 9.75)

      expect(book.exempt).to be true
      expect(cd.exempt).to be false
      expect(chocolate.exempt).to be true
      expect(pills.exempt).to be true
    end

    it 'identifies imported items' do
      item = Item.new('imported book', 12.49)
      expect(item.imported).to be true
    end

    context 'with invalid inputs' do
      it 'raises error for empty name' do
        expect { Item.new('', 12.49) }.to raise_error(ArgumentError, 'Name cannot be empty')
      end

      it 'raises error for nil name' do
        expect { Item.new(nil, 12.49) }.to raise_error(ArgumentError, 'Name cannot be empty')
      end

      it 'raises error for negative price' do
        expect { Item.new('book', -1) }.to raise_error(ArgumentError, 'Price must be positive')
      end

      it 'raises error for zero price' do
        expect { Item.new('book', 0) }.to raise_error(ArgumentError, 'Price must be positive')
      end

      it 'raises error for negative quantity' do
        expect { Item.new('book', 12.49, quantity: -1) }.to raise_error(ArgumentError, 'Quantity must be positive')
      end
    end
  end

  describe '#total_price' do
    it 'calculates total price based on quantity' do
      item = Item.new('book', 12.49, quantity: 2)
      expect(item.total_price).to eq(24.98)
    end
  end
end
