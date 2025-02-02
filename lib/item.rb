# frozen_string_literal: true

class Item
  attr_reader :name, :price, :imported, :exempt, :quantity

  EXEMPT_CATEGORIES = %w[book chocolate pill].freeze

  def initialize(name, price, quantity: 1)
    validate_inputs(name, price, quantity)

    @name = name
    @price = price
    @quantity = quantity
    @imported = name.downcase.include?('imported') ? true : false
    @exempt = EXEMPT_CATEGORIES.any? { |word| name.downcase.include?(word) }
  end

  def total_price
    price * quantity
  end

  private

  def validate_inputs(name, price, quantity)
    raise ArgumentError, 'Name cannot be empty' if name.nil? || name.strip.empty?
    raise ArgumentError, 'Price must be positive' unless price.positive?
    raise ArgumentError, 'Quantity must be positive' unless quantity.positive?
  end
end
