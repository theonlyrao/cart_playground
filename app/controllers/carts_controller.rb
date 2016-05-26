class CartsController < ApplicationController

  def add_to_cart
    #atomic = Faraday.new(url: "http://secure.ultracart.com/")
    if session[:cart].nil?
      session[:cart] = [params[:id]]
    else
      session[:cart] << params[:id]
    end
    # items = session[:cart].map do |id|
    #   item = atomic.get "rest/site/items/#{params[:id]}" do |faraday| 
    #     faraday.headers['X-UC-Merchant-Id'] = 'ATOMA'
    #   end
    #   #CartItem.create(JSON.parse(item))
    #   {"itemID": item, "quantity": 1}.to_json
    # end
    # res = atomic.put "rest/site" do |req|
    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = items
    # end
    # byebug
    # @cart = res.body
    redirect_to root_path
  end

  def view_cart
    @cart = CartMaker.new(session[:cart])
  end
end
