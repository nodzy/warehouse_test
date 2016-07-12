module Shop
  class Basket
    attr_reader :product_id, :id
    attr_accessor :quantity

    @@id = 0 
	
    def initialize(product_id:, quantity:)
      @product_id = product_id
      @quantity = quantity
      @id = set_id
    end

    def fetch_product
      FetchProduct.new.call(product_id)
    end

    def total_price
      product = fetch_product
      product.price * quantity
    end
	
    def total_price_with_vat
      product = fetch_product
      product.price_with_vat * quantity 
    end

    private
    
    def set_id
      @@id += 1
    end
  end
end
