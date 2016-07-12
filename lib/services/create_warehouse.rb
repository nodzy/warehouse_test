module Shop
  class CreateWarehouse
    def call(product_id, quantity)
      WAREHOUSE << Warehouse.new(product_id, quantity)
    end
  end
end
