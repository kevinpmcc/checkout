require_relative './multi_item_promotion'
require_relative './percentage_off_promotion'

class Discounter
  def initialize(
    promotional_rules: [],
    basket: [],
    percentage_off_promotion_klass: PercentageOffPromotion,
    multi_item_promotion_klass: MultiItemPromotion
  )
    @promotional_rules = promotional_rules
    @basket = basket
    @PROMO_TYPES = {
      'percentage_off_basket': percentage_off_promotion_klass,
      'multi_item': multi_item_promotion_klass
    }
  end

  

  def apply
    prioritised_promo_rules.map do |promo_rule|
      @basket = @PROMO_TYPES[promo_rule[:type].to_sym].new(promo_rule, @basket).discounted_basket
    end
    total
  end

  private

  def total
    @basket.inject(0) { |sum, item| sum + item[:discounted_price] }
  end

  def prioritised_promo_rules
    @promotional_rules.sort_by { |promo_rule| promo_rule[:priority] }
  end
end
