module Shop
  class FetchWarehouseProduct
    def call(id)
      return unless id
      WAREHOUSE.find do |warehouse|
        warehouse.product_id == id.to_i
      end
    end
  end
end
