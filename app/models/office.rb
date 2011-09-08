class Office < ActiveRecord::Base
  has_many :users
  belongs_to :locale
  validates_presence_of :name, :locale
end
