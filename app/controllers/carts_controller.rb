class CartsController < ApplicationController

  def add_to_cart
    if session[:cart].nil?
      session[:cart] = [params[:id]]
    else
      session[:cart] << params[:id]
    end
    redirect_to root_path
  end

  def view_cart
    @cart = CartMaker.new(current_cart)
  end

  def remove
    old_cart = CartMaker.new(current_cart)
    @cart = old_cart.remove(params[:id])
    render :view_cart
  end
end
