class SessionsController < ApplicationController
  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=bb2b36e8f42f81ee0583&scope=user"
  end

  def register
    user_and_token = GithubAuth.register(params[:code])
    session[:token] = user_and_token[:token]
    user_data = user_and_token[:user_data]
    user = User.find_by(token: session[:token]) || User.create(username: user_data["login"], url: user_data["html_url"], token: session[:token])
    redirect_to user_path(user)
  end

  def destroy
    session[:token].clear
    redirect_to root_path
  end
end
