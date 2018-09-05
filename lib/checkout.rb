require 'pry'
require_relative './discounter'

class Checkout
  def initialize(
    promotional_rules: [],
    discounter: Discounter
  )
    @discounter
    @promotional_rules = promotional_rules
    @basket = []
  end

  def scan(item)
		@basket << OrderItem.new(item[:code], item[:name], item[:price], item[:price])
  end

  def total
    @basket = Discounter.new(promotional_rules: @promotional_rules, basket: @basket).apply
    number_to_currency(calculate_total)
  end

  private

  def number_to_currency(price)
    format('£%.2f', (price / 100.00).round(2))
  end

  def calculate_total
		@basket.inject(0){|sum, item| sum + item[:reduced_price]}
	end
end

OrderItem = Struct.new(:code, :name, :price, :reduced_price)