require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'

Dir['./lib/**/*.rb'].each { |file| require file }

module Shop
  class App < Sinatra::Base
    set :method_override, true
    use Rack::Flash
    enable :sessions

    get '/' do
      item_categories = DB['select name, price, count(*) from products group by name, price']
      category_price_formatted = item_categories.map { |item| format_price(item[:price]) }
      category_price_with_vat = item_categories.map { |item| format_price(price_with_vat(item[:price])) }
      erb :"warehouses/index", locals: { item_categories: item_categories,
                                         price: category_price_formatted,
                                         price_with_vat: category_price_with_vat }
    end

    post '/' do
      PopulateDatabase.new.call
      redirect '/'
    end

    delete '/' do
      DropDatabase.new.call
      redirect '/'
    end

    get '/products/:name' do |name|
      item_category = DB['select count(*) from products where name = :name', name: name]
      product = Product.where(name: name).first
      price = format_price(product[:price])
      price_with_vat = format_price(price_with_vat(product[:price]))
      erb :"warehouses/show", locals: { product: product, price: price,
                                        price_with_vat: price_with_vat, item_category: item_category }
    end

    get '/basket' do
      products = Basket.all
      item_categories = DB['select name, price, count(*) from basket_items group by name, price']
      sum_for_category = DB['select name, sum(price) as Sum_Total_Price from basket_items group by name']
      total_price = sum_for_category.map { |category| format_price(category[:sum_total_price]) }
      total_price_with_vat = sum_for_category.map { |category| format_price(price_with_vat(category[:sum_total_price])) }
      price = item_categories.map { |category| format_price(category[:price]) }
      price_with_vat = item_categories.map { |category| format_price(price_with_vat(category[:price])) }
      total_sum = Basket.sum(:price)
      total_sum = format_price(price_with_vat(total_sum))
      erb :"basket/show", locals: { basket: products, item_categories: item_categories, sum_for_category: sum_for_category,
                                    total_price: total_price,
                                    total_price_with_vat:  total_price_with_vat,
                                    price: price,
                                    price_with_vat: price_with_vat,
                                    total_sum: total_sum }
    end

    post '/basket' do
      if AddToBasket.new(params).call
        redirect '/'
      else
        flash[:alert] = 'Amount of items you want to add to basket is incorrect!'
        redirect '/'
      end
    end

    delete '/basket' do
      CleanBasket.new.call
      redirect '/'
    end

    delete '/basket/delete' do
      if DeleteFromBasket.new(params).call
        redirect '/'
      else
        flash[:alert] = 'Amount of items you want to remove from basket is incorrect!'
        redirect '/'
       end
    end

    private

    def format_price(price)
      format('$%.2f', price.to_f)
    end

    def price_with_vat(price)
      price.to_f * 1.23
    end
  end
end
