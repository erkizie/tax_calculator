# frozen_string_literal: true

RSpec.describe TaxCalculator do
  describe '.calculate_tax' do
    context 'with exempt domestic items' do
      it 'calculates zero tax for books' do
        item = Item.new('book', 12.49)
        expect(TaxCalculator.calculate_tax(item)).to eq(0.0)
      end

      it 'calculates zero tax for food' do
        item = Item.new('chocolate bar', 0.85)
        expect(TaxCalculator.calculate_tax(item)).to eq(0.0)
      end

      it 'calculates zero tax for medical products' do
        item = Item.new('headache pills', 9.75)
        expect(TaxCalculator.calculate_tax(item)).to eq(0.0)
      end
    end

    context 'with non-exempt domestic items' do
      it 'calculates 10% tax' do
        item = Item.new('music CD', 14.99)
        expect(TaxCalculator.calculate_tax(item)).to eq(1.50)
      end
    end

    context 'with imported exempt items' do
      it 'calculates 5% import duty' do
        item = Item.new('imported box of chocolates', 10.00)
        expect(TaxCalculator.calculate_tax(item)).to eq(0.50)
      end
    end

    context 'with imported non-exempt items' do
      it 'calculates both basic tax and import duty' do
        item = Item.new('imported bottle of perfume', 47.50)
        expect(TaxCalculator.calculate_tax(item)).to eq(7.15)
      end
    end

    context 'with multiple quantities' do
      it 'calculates tax for all items' do
        item = Item.new('imported box of chocolates', 11.25, quantity: 3)
        expect(TaxCalculator.calculate_tax(item)).to eq(1.80)
      end
    end
  end
end
