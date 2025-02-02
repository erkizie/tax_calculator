# frozen_string_literal: true

RSpec.describe Printer do
  describe '.print' do
    it 'prints the receipt' do
      items = [Item.new('book', 12.49)]
      receipt = Receipt.new(items)

      expect { Printer.print(receipt) }.to output(
        "1 book: 12.49\n" \
        "Sales Taxes: 0.00\n" \
        "Total: 12.49\n"
      ).to_stdout
    end
  end
end
