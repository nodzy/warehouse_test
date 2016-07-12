require_relative './fetch_warehouse'

module Shop
  class DeleteWarehouse
    def call(id, quantity)
      warehouse = FetchWarehouse.new.call(id)

      return unless warehouse

      reduce_warehouse_quantity(warehouse, quantity)
    end

    private

    def reduce_warehouse_quantity(warehouse, quantity)
      if warehouse.quantity > quantity
        warehouse.quantity -= quantity
      else
        WAREHOUSE.delete(warehouse)
      end
    end
  end
end
