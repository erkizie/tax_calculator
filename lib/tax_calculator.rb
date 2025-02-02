# frozen_string_literal: true

class TaxCalculator
  BASIC_SALES_TAX = 0.10
  IMPORT_DUTY = 0.05
  ROUNDING_FACTOR = 20.0

  class << self
    def calculate_tax(item)
      new(item).calculate
    end
  end

  def initialize(item)
    @item = item
  end

  def calculate
    base_price = item.price
    total_tax = 0.0

    total_tax += round_tax(base_price * basic_sales_tax)
    total_tax += round_tax(base_price * import_duty)

    (total_tax * item.quantity).round(2)
  end

  private

  attr_reader :item

  def basic_sales_tax
    item.exempt ? 0.0 : BASIC_SALES_TAX
  end

  def import_duty
    item.imported ? IMPORT_DUTY : 0.0
  end

  def round_tax(amount)
    return 0.0 if amount.zero?

    ((amount * ROUNDING_FACTOR).ceil / ROUNDING_FACTOR)
  end
end
