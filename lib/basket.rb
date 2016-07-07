class Basket
  require_relative "./product"
  require_relative "./warehouse"
  attr_reader :products, :shop
  
  def initialize(shop)
    @products = []
    @shop = shop
  end  
  
  def add(product)
    if shop.products.select{|p| p.id == product.id}.count >= 1
      shop.products.
        delete_at(shop.products.
          find_index{|p| p.id == product.id})
      products << product
    else
      raise RangeError
      p "Item out of stock"
    end
  end

  def remove(product)
    if !products.empty?
      shop.products << product
      products.delete_at(products.
        find_index{|p| p.id == product.id})
     else raise RangeError
     end
  end
  
  def sum
    products.map(&:price).inject(:+)
  end

  def final_sum
    products.map(&:price_with_vat).inject(:+)
  end

  def print_basket
    puts "\n\You're shopping in #{shop.city}\tName:\tPrice:\tQty:"
    products.
      sort{|a,b| a.name <=> b.name}.
        uniq.each do |p|
	  puts "\t\t\t\t#{p.name}\t#{Product.price_formatted(p.price)}\t#{products.select{|e| e.name == p.name}.count}"
	end
    puts "\n\tSum: #{Product.price_formatted(sum)}\n"
    puts "\tSum with VAT: #{Product.price_formatted(final_sum)}\n"
  end

end
