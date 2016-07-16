require 'sequel'
module Shop
  DB = Sequel.connect('postgres://malena:test_password@localhost/products_development')
  class Basket < Sequel::Model(:basket_items)
  end
end
