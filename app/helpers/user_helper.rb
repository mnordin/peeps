module UserHelper

  def me
    User.find_by_email(session[:user][:email])
  end

  def locales
    [
      "Stockholm",
      "Malmoe",
      "Gothenburg",
      "Oslo",
      "Helsinkki",
      "Singapore",
      "London"
    ]
  end

end
