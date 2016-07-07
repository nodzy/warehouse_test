class Product
  attr_accessor :name, :price, :vat, :id, :sale
  @@id = 0

  def initialize(name:, price:, vat:, sale: false)
    @id = next_id
    @name = set_name(name)
    @price = set_price(price)
    @vat = set_vat(vat)
    @sale = sale
  end 

  
  def self.price_formatted(price)
    format("$%.2f", price)
  end

  def price_with_vat
    price * (1 + vat)
  end
  
  private
  def set_name(name)
    raise ArgumentError unless name.is_a?(String)
    raise ArgumentError if name.length < 3
    name
  end

  def set_price(price)
    raise ArgumentError unless price.is_a?(Numeric)
    raise ArgumentError if price <= 0
    price
  end

  def set_vat(vat)
    raise ArgumentError unless vat.is_a?(Numeric)
    vat
  end
  
  def next_id
    @@id += 1
  end

end
