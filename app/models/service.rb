class Service < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :minutes_duration, presence: true, numericality: true

  has_many :events, dependent: :destroy

  belongs_to :user

  scope :per_user, ->(user_id) { where("services.user_id = ? ", user_id )} #.includes(:proposals)}

end
