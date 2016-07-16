require 'sequel'
module Shop
  class PopulateDatabase
    def call
      items = DB[:products]
      
      5.times do
        items.insert(
          name: 'Book',
          price: 5.0,
          description: 'Very interesting book'
        )
      end
      
      15.times do
        items.insert(
          name: 'Paper',
          price: 7.0,
          description: 'Great paper'
        )
      end
      
      25.times do
        items.insert(
          name: 'Pen',
          price: 2.0,
          description: 'Excellent pen'
        )
      end
    end
  end
end
