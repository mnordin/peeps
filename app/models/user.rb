class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true

  def name
    "#{first_name} #{last_name}"
  end

  def self.find_or_create_by_email(hash)
    email = hash["user_info"]["email"]
    if user = User.find_by_email(email)
      return user
    else
      new_user = User.create(:first_name => hash["user_info"]["first_name"], :last_name => hash["user_info"]["last_name"], :email => email)
      return new_user
    end
  end

end
