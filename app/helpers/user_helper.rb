module UserHelper

  def me
    User.find_by_email(session[:user][:email])
  end

  def locales
    [
      {:stockholm => "Stockholm"},
      {:malmo => "Malmoe"},
      {:gothenburg => "Gothenburg"},
      {:oslo => "Oslo"},
      {:helsinkki => "Helsinkki"},
      {:singapore => "Singapore"},
      {:london => "London"}
    ]
  end

end
