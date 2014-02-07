class TimeSlot < ActiveRecord::Base

  validates :starts_at, :presence => true
  validates :ends_at, :presence => true

  validates :event, :presence => true

  belongs_to :event

  belongs_to :contact

  before_update :check_token


  def free?
    !self.contact
  end

  private

  def check_token
    if self.contact && !self.token
      self.token = Random.rand(1000...10000).to_s
    end
  end

end
