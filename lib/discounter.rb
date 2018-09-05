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
      'multi_item': multi_item_promotion_klass,
      'percentage_off_basket': percentage_off_promotion_klass
    }
  end

  def discount_basket
    prioritised_promo_rules.map { |promo_rule| 
      @basket = @PROMO_TYPES[promo_rule[:type].to_sym].new(promo_rule, @basket).discount_basket
    }
    @basket
  end

  private

  def prioritised_promo_rules
    @promotional_rules.sort_by { |promo_rule| promo_rule[:priority] }
  end
end
