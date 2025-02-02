# frozen_string_literal: true

class Printer
  class << self
    def print(receipt)
      new(receipt).print
    end
  end

  def initialize(receipt)
    @receipt = receipt
  end

  def print
    receipt.generate.each do |line|
      puts line
    end
  end

  private

  attr_reader :receipt
end
