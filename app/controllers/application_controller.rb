class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_cart
  
  private

  def current_user
    @user ||= User.find_by(token: session[:token])
  end

  def current_cart
    @current_cart ||= session[:cart]
  end
end
