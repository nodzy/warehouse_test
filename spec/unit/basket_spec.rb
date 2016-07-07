require_relative '../../lib/basket'

RSpec.describe Basket do
  let(:shop) { Warehouse.new(city: "Cracow", employees: 100) }
  let(:product) { Product.new(name: "Notebook", price: 20, vat: 0.23) }
  before { 5.times { shop.add(product) }}
  let(:basket) { Basket.new(shop)}

  it "has 1 param" do
    expect {
      Basket.new(nil)
    }.to_not raise_error
  end 
  
  context "#products" do
    it "returns proper value" do
      expect(basket.products).to be_a(Array)  
    end
  end

  context "#shop" do
    it "returns proper value" do
      expect(basket.shop).to eql(shop)
    end
  end

  context "#add" do
    it "can't add to basket if item out of stock" do
      expect { 
        6.times{ basket.add(product) }
      }.to raise_error(RangeError)
    end

    it "can add all available items to basket" do
      expect { 
        5.times{ basket.add(product) }
      }.to_not raise_error(RangeError)
    end

    it "changes quantity on hand" do
      3.times{ basket.add(product)}
      expect(shop.products.count).to eql(2)
    end
  end

  context "#remove" do
    it "can't remove from basket if empty" do
      expect { 
        basket.remove(product)
      }.to raise_error(RangeError)
    end

    it "changes quantity in basket" do
      3.times{ basket.add(product)}
      basket.remove(product)
      expect(basket.products.count).to eql(2)
    end

   it "changes quantity on hand" do
     3.times{ basket.add(product)}
     basket.remove(product)
     expect(shop.products.count).to eql(3)
    end
  end
end
