class SessionsController < ApplicationController

  def callback
    if request.env["omniauth.auth"]
      google_apps_callback if params[:provider] == "google_apps"
      facebook_callback if params[:provider] == "facebook"
    else
      redirect_to root_path, :notice => "Omniauth failure"
    end
  end

  def google_apps_callback
    restrict_blocked_google_accounts
    session[:user] = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
    redirect_to root_path
  end

  def facebook_callback
    user = FbGraph::User.me(request.env["omniauth.auth"]["credentials"]["token"])
    user.fetch
    render :json => user.photos.each do |photo|
      photo.images
    end
  end

  def failure
    render :text => "Fail"
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

  private

  def restrict_blocked_google_accounts
    blocked_accounts = %w(kundtjanst teknisk-support)
    username = request.env["omniauth.auth"]["user_info"]["email"].split("@").first
    if blocked_accounts.include?(username)
      redirect_to root_path
    end
    return true
  end

end