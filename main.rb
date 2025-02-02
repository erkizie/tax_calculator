# frozen_string_literal: true

require_relative 'lib/item'
require_relative 'lib/tax_calculator'
require_relative 'lib/receipt'
require_relative 'lib/parser'
require_relative 'lib/printer'
require_relative 'lib/line_item'

class SalesTaxCalculator
  class << self
    def run
      new.run
    end
  end

  def run
    input_data = collect_input
    process_input(input_data)
  rescue ArgumentError => e
    puts "Error: #{e.message}"
    exit 1
  end

  private

  def collect_input
    puts "Enter your shopping items (type 'done' to finish):"
    input_lines = []

    loop do
      line = gets&.chomp
      break if line.nil? || line.downcase == 'done'

      input_lines << line
    end

    raise ArgumentError, 'Input cannot be empty' if input_lines.empty?

    input_lines.join("\n")
  end

  def process_input(input_data)
    items = Parser.parse(input_data)
    receipt = Receipt.new(items)
    Printer.print(receipt)
  end
end

SalesTaxCalculator.run if __FILE__ == $PROGRAM_NAME
