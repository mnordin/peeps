class UsersController < ApplicationController
  before_filter :require_authed_user

  def index
    @users = User.all.sort_by { rand }
  end

  def edit
    @user = User.find_by_email(session[:user][:email])
    if session[:fb_access_token]
      user = FbGraph::User.me(session[:fb_access_token])
      user.fetch
      @photos = user.photos.map { |photo| photo.images }
      logger.info @photos
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

  def get_photos
    user = FbGraph::User.me("194756060575091|2.AQAEgNohmvog4xXS.3600.1309968000.0-697496456|BTq5p2ZEI7wjujxSQQkbAz1LFJQ")
    user.fetch
    render :json => user.picture
  end

  private
  def require_authed_user
    redirect_to "/auth/google_apps" if session[:user].nil?
  end
end
