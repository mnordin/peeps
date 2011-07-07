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
    logger.info "*****************************************"
    logger.info request.env["omniauth.auth"].to_yaml
    logger.info "*****************************************"
    user = FbGraph::User.me(request.env["omniauth.auth"]["credentials"]["token"])
    user.fetch
    render :json => user.photos.to_yaml
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