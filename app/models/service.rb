class Service < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :minutes_duration, presence: true, numericality: true

  has_many :events, dependent: :destroy

end
