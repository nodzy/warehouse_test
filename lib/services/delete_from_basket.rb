require 'sequel'
module Shop
  class DeleteFromBasket
    attr_reader :name, :quantity, :price, :description
    
    def initialize(params)
      @name = params.fetch('name')
      @quantity = params.fetch('quantity').to_i
      @price = params.fetch('price').to_f
      @description = params.fetch('description')
    end

    def call
      products = DB[:products]
      basket_items = DB[:basket_items]
      dataset = DB['select count(*) from basket_items where name = :name', name: name]
      if dataset[:count][:count] >= quantity && quantity > 0
        quantity.times do
          Basket.where(name: name).first.delete
        end
        quantity.times do
          products.insert(
            name: name,
            price: price,
            description: description
          )
        end

      end
    end
  end
end
