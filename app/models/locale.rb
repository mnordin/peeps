class Locale < ActiveRecord::Base
  has_many :offices
  validates_presence_of :name
end
