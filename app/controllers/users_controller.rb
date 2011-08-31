class UsersController < ApplicationController
  before_filter :require_authed_user

  def index
    @users = User.all.sort_by { rand }
  end

  def edit
    @user = User.find(session[:user_id])
    if session[:fb_access_token]
      user = FbGraph::User.me(session[:fb_access_token])
      user.fetch
      @photos = user.albums.select{ |a| a.type == "profile" }.first.photos
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to(root_path, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
  def require_authed_user
    redirect_to "/auth/google_apps" if session[:user_id].nil?
  end
end
