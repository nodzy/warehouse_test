Dir['./lib/**/*.rb'].each { |file| require file }

module Shop
  class DeleteBasket
    attr_reader :id

    def initialize(params)
      @id = params.fetch('id').to_i
    end

    def call
      basket = FetchBasket(id)

      return unless basket

      reduce_basket_quantity(basket)
    end

    private

    def reduce_basket_quantity(basket)
      if basket.quantity >= 1
        basket.quantity -= 1
      # warehouse = FetchWarehouseProduct.new.call(basket.product_id)
      # warehouse.quantity += 1
      else
        BASKET.delete(basket)
      end
    end
  end
end
