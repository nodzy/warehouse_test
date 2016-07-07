class Warehouse
  require_relative "./product"
  attr_accessor :city, :employees, :products

  def initialize(city:, employees:)
    @city = set_city(city)
    @employees = set_employees(employees)
    @products = []
  end 

  def add(product)
    products << product
  end

  def remove(product)
    if !products.empty?
      products.delete_at(products.
        find_index{|p| p.id == product.id})
    else raise RangeError
    end
  end
  
  def sale(product, per)
    product.price -= (product.price * per)
    product.sale = true
  end
  
  def sum_in_stock
    products.map(&:price).inject(:+)
  end

  def final_sum_in_stock
    products.map(&:price_with_vat).inject(:+)
  end	
  
  def print_stock
    puts "\n\tCity:\t#{city}\t\tName:\t\tPrice:\t\tQty:"
    products.sort{|a,b| a.name <=> b.name}.
      uniq.each do |p|
        puts "\t\t\t\t#{p.name}\t\t#{Product.price_formatted(p.price)}\t\t#{@products.select{|e| e.name == p.name}.count}"
      end
    puts "\n\tSum: #{Product.price_formatted(sum_in_stock)}\n"
    puts "\tSum with VAT: #{Product.price_formatted(final_sum_in_stock)}\n"
    puts "\n\t #{products.select{|p| p.sale == true}.
      uniq.map{|p| p.name}} on sale!" if products.select{|p| p.sale == true}.any?  
  end

  private
  def set_city(city)
    raise ArgumentError unless city.is_a?(String)
    raise ArgumentError if city.length <= 3
    city
  end

  def set_employees(employees)
    raise ArgumentError unless employees.is_a?(Numeric)
    raise ArgumentError if employees < 0
    employees
  end

end
