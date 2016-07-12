module Shop
  class FetchBasket
    def call(id)
      return unless id
      BASKET.find do |basket|
        basket.id == id.to_i
      end
    end
  end
end
