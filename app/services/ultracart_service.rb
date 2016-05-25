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
    new_cart = atomic.put "rest/site" do |faraday| 
      faraday.headers['Content-Type'] = 'application-json'
      faraday.headers['X-UC-Merchant-Id'] = 'ATOMA'      
      faraday.body = {'items' => item}
    end
  end
end
