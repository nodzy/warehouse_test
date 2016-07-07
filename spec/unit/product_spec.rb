require_relative '../../lib/product'

RSpec.describe Product do
  let(:product) { Product.new(name: "Notebook", price: 10, vat: 0.23) }

  it "has 4 params" do
    expect {
      Product.new(name: "Notebook", price: 10, vat: 0.23, sale: true)
    }.to_not raise_error
  end

  it "has 1 default param" do
    expect {
      Product.new(name: "Notebook", price: 10, vat: 0.23)
    }.to_not raise_error
  end

  context "#name" do
    it "returns proper value" do
      expect(product.name).to eql("Notebook")
    end
  
    it "must be string" do
      expect {
        Product.new(name: 123, price: 10, vat: 0.23).name
      }.to raise_error(ArgumentError)
    end
  
    it "must be at least 3 characters long" do
      expect{
        Product.new(name: "", price: 10, vat: 0.23).name
      }.to raise_error(ArgumentError)
    end
  end

  context "#price" do
    it "returns proper value" do
      expect(product.price).to eql(10)
    end

    it "can't be negative" do
      expect{
        Product.new(name: "Book", price: -10, vat: 0.23).price
      }.to raise_error(ArgumentError)
    end

    it "must be numeric" do
      expect{
        Product.new(name: "Book", price: "price", vat: 0.23).price
      }.to raise_error(ArgumentError)
    end
  end

    context "#vat" do
      it "returns proper value" do
        expect(product.vat).to eql(0.23)
      end

      it "must be numeric" do
        expect{
          Product.new(name: "Book", price: 20, vat: "vat").vat
        }.to raise_error(ArgumentError)
    end
  end

  context "#sale" do
    it "returns proper value" do
      expect(product.sale).to eql(false)
    end
  end

   context ".price_formatted" do
     it "returns proper format" do
       expect(Product.price_formatted(2.50)).to match(/\$\d.\d{2}/)
     end
  end

  context "#price_with_vat" do
    it "returns proper value" do
      expect(product.price_with_vat).to eql(12.30)
    end
  end
end
