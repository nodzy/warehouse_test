module Shop
  class FetchBasketProduct
    def call(id)
      return unless id
      BASKET.find do |basket|
        basket.product_id == id.to_i
      end
    end
  end
end
