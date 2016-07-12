require 'bundler/setup'
require 'sinatra/base'

Dir['./lib/**/*.rb'].each { |file| require file }

module Shop
  PRODUCTS = [
    Product.new('foo', 12, 0.23),
    Product.new('bar', 21, 0.08),
    Product.new('baz', 22, 0.05)
  ]

  WAREHOUSE = [
    Warehouse.new(1, 200),
    Warehouse.new(2, 100)
  ]

  BASKET = []

  class App < Sinatra::Base
    get '/' do
      products = FetchWarehouses.new.call
      erb :"warehouses/index", locals: { products: products, title: 'Products' }
    end

    get '/products/:id' do |product_id|
      warehouse = FetchWarehouse.new.call(product_id)
      erb :"warehouses/show", locals: { warehouse: warehouse }
    end

    get '/basket' do
      products_in_basket = FetchBaskets.new.call
      erb :"basket/show", locals: { basket: products_in_basket }
    end

    post '/basket' do
      AddToBasket.new(params).call
      redirect '/'
    end

    delete 'basket/:id' do
      DeleteBasket.new(params).call
      redirect '/'
    end
  end
end
