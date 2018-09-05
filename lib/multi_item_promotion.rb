class MultiItemPromotion
  def initialize(promo_rule, basket)
    @promo_rule = promo_rule
    @basket = basket
  end

  def discount_basket
    eligible? ? reduced_basket : @basket
  end
  
  private

  def eligible?
    @basket.count { |item| item[:code] == @promo_rule[:item_code] } >= @promo_rule[:eligible_min_quantity]
  end

  def reduced_basket
    @basket.map {|item|
      item[:reduced_price] = @promo_rule[:reduced_price] if item[:code] == @promo_rule[:item_code] 
      item
    }
  end
end
