# frozen_string_literal: true

class Parser
  ITEM_PATTERN = /^(\d+) (.+) at (-?\d+\.\d{2})$/.freeze

  def self.parse(input)
    raise ArgumentError, 'Input cannot be empty' if input.nil? || input.strip.empty?

    items = input.lines.map do |line|
      parse_line(line.strip)
    end.compact

    raise ArgumentError, 'No valid items found' if items.empty?

    items
  end

  def self.parse_line(line)
    match = line.match(ITEM_PATTERN)
    raise ArgumentError, "Invalid format: '#{line}'" unless match

    quantity = match[1].to_i
    name = match[2]
    price = match[3].to_f

    raise ArgumentError, 'Quantity must be positive' unless quantity.positive?
    raise ArgumentError, 'Price must be positive' unless price.positive?

    Item.new(name, price, quantity: quantity)
  rescue ArgumentError => e
    puts "Warning: Skipping invalid line: #{e.message}"
    nil
  end
end
