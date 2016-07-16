require 'sequel'
module Shop
  DB = Sequel.connect('postgres://malena:test_password@localhost/products_development')
  class Product < Sequel::Model(:products)
  end
end
