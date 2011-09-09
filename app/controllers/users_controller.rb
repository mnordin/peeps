class UsersController < ApplicationController
  before_filter :require_authed_user

  def index
    @locales = Locale.all
    if params[:office].present?
      @users = Office.find_by_code(params[:office]).users
    else
      @users = User.all
    end
  end

  def edit
    @locales = Locale.all
    @user = User.find(session[:user_id])
    if @user.fb_access_token
      user = FbGraph::User.me(@user.fb_access_token)
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
