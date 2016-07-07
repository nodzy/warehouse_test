class Main
  require_relative "./basket"
  require_relative "./product"
  require_relative "./warehouse"

  product1 = Product.new(name:"Book", price: 20, vat: 0.08)
  product2 = Product.new(name:"Pen", price: 5, vat: 0.05)
  product3 = Product.new(name:"Bag", price: 50, vat: 0.23)
  product4 = Product.new(name:"Cup", price: 20, vat: 0.08)
  product5 = Product.new(name:"Brush", price: 10, vat: 0.23)
  product6 = Product.new(name:"Water", price: 2.50, vat: 0.23)
  product7 = Product.new(name:"Apple", price: 5, vat: 0.23)
  product8 = Product.new(name:"Game", price: 90, vat: 0.23)
  product9 = Product.new(name:"Juice", price: 5, vat: 0.23)
  shop1 = Warehouse.new(city: "Cracow", employees: 20)
  shop2 = Warehouse.new(city: "Warsaw", employees: 40)
  40.times{shop1.add(product1)}
  40.times{shop1.add(product2)}
  30.times{shop1.add(product3)}
  40.times{shop1.add(product4)}
  70.times{shop1.add(product5)}
  40.times{shop1.add(product6)}
  20.times{shop1.add(product7)}
  10.times{shop1.add(product8)}
  shop1.print_stock
  2.times{shop1.remove(product1)}
  shop1.print_stock
  40.times{shop2.add(product1)}
  40.times{shop2.add(product2)}
  30.times{shop2.add(product3)}
  40.times{shop2.add(product4)}
  70.times{shop2.add(product5)}
  40.times{shop2.add(product6)}
  20.times{shop2.add(product7)}
  10.times{shop2.add(product8)}
  shop2.print_stock
  basket1 = Basket.new(shop2)
  2.times{basket1.add(product1)}
  2.times{basket1.add(product2)}
  basket1.print_basket
  basket1.remove(product1)
  basket1.print_basket
  shop2.sale(product1, 0.20)  #przecena
  shop2.sale(product2, 0.5)  
  shop2.print_stock                           
  basket2 = Basket.new(shop2)
  2.times{basket2.add(product1)}
  2.times{basket2.add(product2)}
  basket2.print_basket                        
  
end
