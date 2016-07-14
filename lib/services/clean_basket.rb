require 'sequel'
module Shop
  class CleanBasket
    def call
      products = DB[:products]
      basket_items = DB[:basket_items]
      basket_items.each do |item|
        products.insert(
          name: item[:name],
          price: item[:price],
          description: item[:description]
        )
      end
      basket_items.delete
      end
  end
end
