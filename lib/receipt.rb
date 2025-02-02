# frozen_string_literal: true

class Receipt
  def initialize(items)
    @items = items
  end

  def generate
    [
      *line_items.map(&:to_s),
      tax_line,
      total_line
    ]
  end

  private

  attr_reader :items

  def line_items
    @line_items ||= items.map { |item| LineItem.new(item) }
  end

  def total_taxes
    line_items.sum(&:tax)
  end

  def total_price
    line_items.sum(&:total)
  end

  def tax_line
    "Sales Taxes: #{format_price(total_taxes)}"
  end

  def total_line
    "Total: #{format_price(total_price)}"
  end

  def format_price(amount)
    format('%.2f', amount)
  end
end
