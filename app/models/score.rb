class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :office

  #validates :office - office with 0 is a global game
  validates :user, :presence => true
  validates :correct_peeps, :presence => true

  before_create :validate_user_photo


  def validate_user_photo
    User.find(session[:user_id]).photo?
  end
end
