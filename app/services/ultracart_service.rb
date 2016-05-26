class UltracartService

  def initialize
    @atomic = Faraday.new(url: "http://secure.ultracart.com/") 
  end
  
  def get_item(id)
    raw_item = @atomic.get "rest/site/items/#{id}" do |faraday| 
      faraday.headers['X-UC-Merchant-Id'] = 'ATOMA'
    end
    parse(raw_item)
  end

  def add_item(items)
    raw_cart = @atomic.put "rest/cart" do |faraday| 
      faraday.body = {"merchantId": ENV["merchant_id"], "items": items, "cartID": ""}.to_json
    end
    parse(raw_cart)
  end

  def remove_item(remove, all)
    all.delete_at(all.index(remove))
    items = all.map do |id|
      self.get_item(id)
    end
    self.add_item(items)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
