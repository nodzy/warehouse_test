module Shop
  class AddToBasket
    attr_reader :product_id, :quantity

    def initialize(params)
      @product_id = params.fetch('product_id').to_i
      @quantity = params.fetch('quantity').to_i
    end

    def call
      if FetchWarehouseProduct.new.call(product_id).quantity >= quantity
        BASKET << Basket.new(
          product_id: product_id,
          quantity: quantity
        )
        warehouse = FetchWarehouseProduct.new.call(product_id)
        DeleteWarehouse.new.call(warehouse.id, quantity)

      else raise RangeError
    end
  end
end
end
