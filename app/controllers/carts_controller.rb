class CartsController < ApplicationController

  def add_to_cart
    atomic = Faraday.new(url: "http://secure.ultracart.com/")
    item = atomic.get "rest/site/items/#{params[:id]}" do |faraday| 
     faraday.headers['X-UC-Merchant-Id'] = 'ATOMA'
    end
    if session[:cart].nil?
      session[:cart] = [params[:id]]
    else
      session[:cart] << params[:id]
    end
    
    redirect_to root_path
  end
end
