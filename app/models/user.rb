class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true
  
  # Paperclip
  # Soon to be deprecated
  has_attached_file :photo,
    :path => "/:rails_root/public/:class/:attachment/:id/:style_:basename.:extension",
    :url => "/:class/:attachment/:id/:style_:basename.:extension",
    :styles => {
      :thumb => "250x250>",
      :slideshow => "550x550>"
    },
    :default_style => :small

  def name
    "#{first_name} #{last_name}"
  end

  def self.find_or_create_from_omniauth(hash)
    email = hash["user_info"]["email"]
    if user = User.find_by_email(email)
      return user
    else
      new_user = User.create(:first_name => hash["user_info"]["first_name"], :last_name => hash["user_info"]["last_name"], :email => email)
      return new_user
    end
  end

end
