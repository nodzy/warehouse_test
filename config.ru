require 'bundler/setup'
require 'sequel'
require_relative './shop'
DB = Sequel.connect('postgres://malena:test_password@localhost/products_development')
run Shop::App.new
