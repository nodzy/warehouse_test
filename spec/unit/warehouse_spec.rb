require_relative '../../lib/warehouse'

RSpec.describe Warehouse do
  let(:shop) { Warehouse.new(city: "Cracow", employees: 100) }
  let(:product) { Product.new(name: "Notebook", price: 20, vat: 0.23) }
  before { 5.times { shop.add(product) }}
  let(:basket) { Basket.new(shop)}

  it "has 2 params" do
    expect {
      Warehouse.new(city: "Cracow", employees: 100)
    }.to_not raise_error(ArgumentError)
  end
  
  context "#products" do
    it "returns proper value" do
      expect(shop.products).to be_a(Array)  
    end
   end

  context "#city" do
    it "returns proper value" do
      expect(shop.city).to eql("Cracow")
    end
  
    it "must be string" do
      expect{
        Warehouse.new(city: 123, employees: 100).city
      }.to raise_error(ArgumentError)
    end
  
    it "must be at least 3 characters long" do
      expect{
        Warehouse.new(city: "", employees: 100).city
      }.to raise_error(ArgumentError)
    end
  end
  
  context "#employees" do
    it "returns proper value" do
      expect(shop.employees).to eql(100)
    end
  
    it "can't be negative" do
      expect{
        Warehouse.new(city: "Cracow", employees: -10).employees
      }.to raise_error(ArgumentError)
    end

    it "must be numeric" do
      expect{
        Warehouse.new(city: "Cracow", employees: "employees").city
      }.to raise_error(ArgumentError)
    end
  end

  context "#add" do
    it "changes quantity on hand" do
      6.times{ shop.add(product) }
        expect(shop.products.count).to eql(11)
    end
  end

  context "#remove" do
    it "can't remove from shop if everything is out of stock" do
      expect{ 
        6.times{ shop.remove(product) }
      }.to raise_error(RangeError)
    end

    it "changes quantity on hand" do
      shop.remove(product)
      expect(shop.products.count).to eql(4)
    end
  end
  
  context "#sale" do
    it "changes price" do
      shop.sale(product, 0.5)
      expect(product.price).to eql(10.0)
    end
end
end
