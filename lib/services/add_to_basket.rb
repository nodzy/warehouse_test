require 'sequel'
module Shop
  class AddToBasket
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
      dataset = DB['select count(*) from products where name = :name', name: name]
      if dataset[:count][:count] >= quantity && quantity > 0
        quantity.times do
          basket_items.insert(
            name: name,
            price: price,
            description: description
          )
        end
        quantity.times do
          Product.where(name: name).first.delete
        end
      end
    end
  end
end
