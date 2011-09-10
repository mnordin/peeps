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
    user = User.find_or_create_by_email(request.env["omniauth.auth"])
    user.update_attributes({
      :number_of_logins => user.number_of_logins + 1,
      :last_logged_in => Time.now
    })
    session[:user_id] = user.id
    redirect_to root_path
  end

  def facebook_callback
    #User.find(session[:user_id]).update_attribute(:fb_access_token, request.env["omniauth.auth"]["credentials"]["token"])
    session[:fb_access_token] = request.env["omniauth.auth"]["credentials"]["token"]
    redirect_to edit_your_user_path
  end

  def failure
    render :text => "Fail"
  end

  def destroy
    session[:user_id] = nil
    session[:user] = nil
    session[:fb_access_token] = nil
    redirect_to root_path
  end

  private

  def restrict_blocked_google_accounts
    blocked_accounts = %w(kundtjanst teknisk-support globalmarketing)
    username = request.env["omniauth.auth"]["user_info"]["email"].split("@").first
    if blocked_accounts.include?(username)
      render :text => "You can't use that Google Account, please use your personal account"
    end
    return true
  end
end