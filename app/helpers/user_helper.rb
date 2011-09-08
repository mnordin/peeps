module UserHelper

  def me
    User.find(session[:user_id])
  end

end
