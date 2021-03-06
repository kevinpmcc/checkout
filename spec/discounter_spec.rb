require_relative '../lib/discounter'
require_relative '../lib/order_item'

describe Discounter do
  let(:percentage_off_promotion) { double(:percentage_off_promotion) }
  let(:percentage_off_promotion_instance) { double(:percentage_off_promotion_instance) }
  let(:multi_item_promotion) { double(:multi_item_promotion) }
  let(:multi_item_promotion_instance) { double(:multi_item_promotion_instance) }

  it 'returns the original basket when there are no discounts to apply' do
    chair1 = OrderItem.new('001', 'Very Cheap Chair', 925, 925)
    chair2 = OrderItem.new('001', 'Very Cheap Chair', 925, 925)
    table1 = OrderItem.new('002', 'Little table', 4500, 4500)
    promotional_rules = []
    basket = [chair1, chair2, table1]

    discounter = Discounter.new(
      promotional_rules: promotional_rules,
      basket: basket,
      percentage_off_promotion_klass: percentage_off_promotion,
      multi_item_promotion_klass: multi_item_promotion
    )

    expect(discounter.discounted_basket).to eq basket
  end

  it 'with two promo_rules, it calls the second priority with result of first priority' do
    chair1 = OrderItem.new('001', 'Very Cheap Chair', 925, 925)
    chair2 = OrderItem.new('001', 'Very Cheap Chair', 925, 925)
    light1 = OrderItem.new('003', 'Funky light', 1995, 1995)
    discounted_chair = OrderItem.new('001', 'Very Cheap Chair', 925, 850)

    percentage_off_rule = {
      type: 'percentage_off_basket',
      eligible_min_amount: 6000,
      percentage: 10,
      priority: 1,
    }
    multi_item_rule = {
      type: 'multi_item',
      eligible_min_quantity: 2,
      item_code: '001',
      discounted_price: 850,
      priority: 0,
    }
    promotional_rules = [percentage_off_rule, multi_item_rule]
    basket = [chair1, chair2, light1]
    discounted_basket = [discounted_chair, discounted_chair, light1]
    multi_item_promotion_instance_response = discounted_basket
    allow(multi_item_promotion).to receive(:new).and_return(multi_item_promotion_instance)
    allow(multi_item_promotion_instance).to receive(:discounted_basket).and_return(
      multi_item_promotion_instance_response
    )
    allow(percentage_off_promotion).to receive(:new).and_return(
      percentage_off_promotion_instance
    )
    allow(percentage_off_promotion_instance).to receive(:discounted_basket).and_return(
      multi_item_promotion_instance_response
    )

    discounter = Discounter.new(
      promotional_rules: promotional_rules,
      basket: basket,
      percentage_off_promotion_klass: percentage_off_promotion,
      multi_item_promotion_klass: multi_item_promotion
    )

    expect(percentage_off_promotion).to receive(:new).with(
      percentage_off_rule, multi_item_promotion_instance_response
    )

    discounter.discounted_basket
  end
end
