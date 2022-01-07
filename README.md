# salesApp

Assumes Ruby > 2.4 and Rspec installed locally

Example usage from `irb`:
```
require "./sales_app"
input = <<~CSV
          Quantity,Product,Price
          1,book,12.49
          1,music cd,14.99
          1,chocolate bar,0.85
        CSV

SalesApp.new.get_receipt(input); nil
```
