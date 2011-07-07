class SessionsController < ApplicationController

  def callback
    if request.env["omniauth.auth"]
      if params[:provider] == "google_apps"
        google_apps_callback
      elsif params[:provider] == "facebook"
        facebook_callback
      end
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
    access_token = "194756060575091|4ec8fae636eba5e28c59b52c.0-697496456|xVt6VVqFPgSMKtRu83yJlgqJ9Tw"
    user = FbGraph::User.me(access_token)
    render :json => user.to_yaml
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