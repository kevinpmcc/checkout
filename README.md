# Checkout 

## Details
This is a checkout exercise which totals items scanned and apply promotional discounts.  

## Installation Instructions  
Start by cloning this repository.   
In your favourite terminal

<code>$ git clone https://github.com/kevinpmcc/email_events_stats.git && cd checkout</code>

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