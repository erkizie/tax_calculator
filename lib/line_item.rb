# frozen_string_literal: true

class LineItem
  attr_reader :item, :tax, :total

  def initialize(item)
    @item = item
    @tax = TaxCalculator.calculate_tax(item)
    @total = (item.total_price + tax).round(2)
  end

  def to_s
    "#{item.quantity} #{item.name}: #{format_price(total)}"
  end

  private

  def format_price(amount)
    format('%.2f', amount)
  end
end
