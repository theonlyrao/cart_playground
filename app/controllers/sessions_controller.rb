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
    #hashed = Digest::SHA256.digest(res)
        uri = URI("https://api.github.com/user?#{@user.token}")
    user_data = JSON.parse(Net::HTTP.get(uri))
    @user_name = user_data["login"]
    @user_url = user_data["html_url"]
    @user = User.find_or_create_by(token: session[:token])
    # move three or four lines below here and then update based on these params
    redirect_to user_path(@user)
  end

  def destroy
    session[:token] = nil
  end
end
