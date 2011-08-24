module UserHelper

  def me
    User.find(session[:user_id])
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
