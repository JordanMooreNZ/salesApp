# frozen_string_literal: true

class SalesApp

  require "csv"

  BASE_TAX = 0.1 # 10% on all goods, except books, food, and medical products
  IMPORT_TAX = 0.05 # 5% additional sales tax on all imported goods
  EXCLUDED_PRODUCTS = /book|chocolate|headache pills/i

  def run(input)
    total       = 0.0
    sales_taxes = 0.0
    receipt     = ""

    # Iterate over each product
    CSV.parse(input, headers: true) do |row|
      base_price  = row["Price"].to_f * row["Quantity"].to_i
      base_tax    = row["Product"].match?(EXCLUDED_PRODUCTS) ? 0.0 : BASE_TAX
      import_tax  = row["Product"].include?("imported") ? IMPORT_TAX : 0.0
      # Round sales tax up to nearest 0.05
      sales_tax   = (base_price * (base_tax + import_tax) * 20).ceil / 20.0
      total_price = base_price + sales_tax

      # Add to running totals
      sales_taxes += sales_tax
      total       += total_price

      # Format and add product details to receipt
      row["Price"] = sprintf('%.2f', total_price)
      receipt += row.to_s
    end

    receipt += <<~TOTALS

      Sales Taxes: #{sprintf('%.2f', sales_taxes)}
      Total: #{sprintf('%.2f', total)}
    TOTALS

    puts receipt
    receipt
  end

end
