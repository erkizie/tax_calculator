# frozen_string_literal: true

RSpec.describe Parser do
  describe '.parse' do
    it 'parses valid input' do
      input = "1 book at 12.49\n1 music CD at 14.99"
      items = Parser.parse(input)

      expect(items.size).to eq(2)
      expect(items[0].name).to eq('book')
      expect(items[0].price).to eq(12.49)
      expect(items[1].name).to eq('music CD')
      expect(items[1].price).to eq(14.99)
    end

    it 'handles imported items' do
      input = '1 imported bottle of perfume at 27.99'
      items = Parser.parse(input)

      expect(items[0].imported).to be true
      expect(items[0].name).to eq('imported bottle of perfume')
      expect(items[0].price).to eq(27.99)
    end

    it 'handles multiple quantities' do
      input = '2 book at 12.49'
      items = Parser.parse(input)

      expect(items[0].quantity).to eq(2)
    end

    context 'with invalid input' do
      it 'raises error for empty input' do
        expect { Parser.parse('') }.to raise_error(ArgumentError, 'Input cannot be empty')
      end

      it 'skips invalid lines' do
        input = "1 book at 12.49\ninvalid line\n1 music CD at 14.99"
        items = Parser.parse(input)

        expect(items.size).to eq(2)
      end
    end
  end
end
