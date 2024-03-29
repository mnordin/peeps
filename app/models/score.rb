class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :office

  #validates :office - office with 0 is a global game
  validates :user, :presence => true
  validates :correct_peeps, :presence => true

  before_validation :validate_user_photo

  private
  def validate_user_photo
    user.photo?
  end
end
