class PercentageOffPromotion
  def initialize(promo_rule, basket)
    @promo_rule = promo_rule
    @basket = basket
  end
  
  def discount_basket
    eligible? ? discount_basket_discount : @basket
  end
  
  private

  def eligible?
    calculate_total >= @promo_rule[:eligible_min_amount]	
  end

  def discount_basket_discount
    @basket.map {|item|
      item[:reduced_price] -= discount_to_be_applied(item[:reduced_price])
      item
    }
  end

  def discount_to_be_applied(amount)
    amount / 100.0 * @promo_rule[:percentage]
  end

  def calculate_total
    @basket.inject(0){|sum, item| sum + item[:reduced_price]}
  end
end
