module Shop
  class FetchWarehouse
    def call(id)
      return unless id
      WAREHOUSE.find do |warehouse|
        warehouse.id == id.to_i
      end
    end
  end
end
