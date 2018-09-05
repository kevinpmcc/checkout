# Checkout 
```
      _               _               _   
     | |             | |             | |  
  ___| |__   ___  ___| | _____  _   _| |_ 
 / __| '_ \ / _ \/ __| |/ / _ \| | | | __|
| (__| | | |  __/ (__|   < (_) | |_| | |_ 
 \___|_| |_|\___|\___|_|\_\___/ \__,_|\__|
```

## Details
This is a checkout exercise which totals items scanned and apply promotional discounts.  

## Installation Instructions  
Start by cloning this repository.   
In your favourite terminal

<code>$ git clone https://github.com/kevinpmcc/checkout.git && cd checkout</code>

To install all gems enter  

<code>$ bundle install</code>


### To run tests  
<code>$ rspec</code>

## Technologies used
Ruby  
Rspec for testing  
Rubocop for style  

## BDD style scenarios

Given I scan no items   
Then the total will return £0.00  

Given there are no promotional rules  
When I scan multiple items  
The total will return the combined prices of those items    

Given there is a multiple item promotional rule for chairs  
When I scan two chairs  
The total will return the price including the promotion reduction  

Given there is a percentage promotional rule for 10% off totals over £60  
When I scan items that combine to over £60  
The total will return the price including the promotion reduction  

Given there is a percentage promotional rule  
And there is a multiple item promotional rule for chairs  
When I scan two chairs  
And I scan other items to bring total above threshold  
The total will return the price including both promotion reductions  



## Manual Testing  

### Expected results  
Basket: 001,002,003  
Total price expected: £66.78  

Basket: 001,003,001  
Total price expected: £36.95  

Basket: 001,002,001,003  
Total price expected: £73.76  


In irb or your own favourite Ruby REPL use the below commands to manually test

```
#Setup
require ('./lib/checkout')
require ('./lib/item')
item1 = Item.new('001', 'Very Cheap Chair', 925)
item2 = Item.new('002', 'Little table', 4500)
item3 = Item.new('003', 'Funky light', 1995)

promotional_rules = [{ type: 'percentage_off_basket', eligible_min_amount: 6000, percentage: 10, priority: 1 }, { type: 'multi_item', eligible_min_quantity: 2, item_code: '001', discounted_price: 850, priority: 0 }]

#Scenario 1
co = Checkout.new(promotional_rules: promotional_rules)
co.scan(item1)
co.scan(item2)
co.scan(item3)
co.total
 => "£66.78"

#Scenario 2
co = Checkout.new(promotional_rules: promotional_rules)
co.scan(item1)
co.scan(item3)
co.scan(item1)
co.total
 => "£36.95"

#Scenario 3
co = Checkout.new(promotional_rules: promotional_rules)
co.scan(item1)
co.scan(item3)
co.scan(item2)
co.scan(item1)
co.total
 => "£73.76"
 ```



