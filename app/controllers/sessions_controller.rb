class SessionsController < ApplicationController

  def google_apps_callback
    if request.env["omniauth.auth"]
      session[:user] = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
      redirect_to root_path
    else
      redirect_to root_path, :notice => "Omniauth failure"
    end
  end

  def failure
    render :text => "Fail"
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

end