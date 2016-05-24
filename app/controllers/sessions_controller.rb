require 'net/http'

class SessionsController < ApplicationController
  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=bb2b36e8f42f81ee0583&scope=user"
  end

  def register
    uri = URI.parse("https://github.com/login/oauth/access_token")
    args = { client_id: "bb2b36e8f42f81ee0583",
             client_secret: "4c55a6d7a9ca305714b37ddcbb6ef1e9c6da7a78",
             code: params[:code]
           }
    res = Net::HTTP.post_form(uri, args)
    session[:token] = res.body
    uri = URI("https://api.github.com/user?#{session[:token]}")
    user_data = JSON.parse(Net::HTTP.get(uri))
    @user = User.find_by(token: session[:token]) || User.create(username: user_data["login"], url: user_data["html_url"], token: session[:token])
    redirect_to user_path(@user)
  end

  def destroy
    session[:token] = nil
  end
end
