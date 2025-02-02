# frozen_string_literal: true

RSpec.describe Receipt do
  describe '#generate' do
    it 'generates receipt for input 1' do
      items = [
        Item.new('book', 12.49, quantity: 2),
        Item.new('music CD', 14.99),
        Item.new('chocolate bar', 0.85)
      ]

      receipt = Receipt.new(items)
      output = receipt.generate

      expect(output).to eq([
                             '2 book: 24.98',
                             '1 music CD: 16.49',
                             '1 chocolate bar: 0.85',
                             'Sales Taxes: 1.50',
                             'Total: 42.32'
                           ])
    end

    it 'generates receipt for input 2' do
      items = [
        Item.new('imported box of chocolates', 10.00),
        Item.new('imported bottle of perfume', 47.50)
      ]

      receipt = Receipt.new(items)
      output = receipt.generate

      expect(output).to eq([
                             '1 imported box of chocolates: 10.50',
                             '1 imported bottle of perfume: 54.65',
                             'Sales Taxes: 7.65',
                             'Total: 65.15'
                           ])
    end

    it 'generates receipt for input 3' do
      items = [
        Item.new('imported bottle of perfume', 27.99),
        Item.new('bottle of perfume', 18.99),
        Item.new('packet of headache pills', 9.75),
        Item.new('imported box of chocolates', 11.25, quantity: 3)
      ]

      receipt = Receipt.new(items)
      output = receipt.generate

      expect(output).to eq([
                             '1 imported bottle of perfume: 32.19',
                             '1 bottle of perfume: 20.89',
                             '1 packet of headache pills: 9.75',
                             '3 imported box of chocolates: 35.55',
                             'Sales Taxes: 7.90',
                             'Total: 98.38'
                           ])
    end
  end
end
