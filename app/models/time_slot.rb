class TimeSlot < ActiveRecord::Base

  validates :starts_at, :presence => true
  validates :ends_at, :presence => true

  validates :event, :presence => true

  belongs_to :event

end
