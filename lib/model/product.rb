module Shop
  class Product
    attr_reader :id, :name, :price, :vat

    @@id = 0

    def initialize(name, price, vat)
      @id = set_id
      @name = name
      @price = price
      @vat = vat
    end

    def price_with_vat
      price * (1 + vat)
      end

    def self.price_formatted(price)
      format('$%.2f', price)
      end

    private

    def set_id
      @@id += 1
    end
  end
end
