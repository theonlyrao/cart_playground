class UltracartService

  def get_item(id)
    atomic = Faraday.new(url: "http://secure.ultracart.com/")
    raw_item = atomic.get "rest/site/items/#{id}" do |faraday| 
      faraday.headers['X-UC-Merchant-Id'] = 'ATOMA'
    end
    JSON.parse(raw_item.body)
  end

  def add_item(item)
    atomic = Faraday.new(url: "http://secure.ultracart.com/")
    item_json = item.to_json
    raw_cart = atomic.put "rest/cart" do |faraday| 
      faraday.body = {"merchantId": ENV["merchant_id"], "items": [item], "cartID": ""}.to_json
    end
    JSON.parse(raw_cart.body)
  end
end
