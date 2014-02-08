class TimeSlot < ActiveRecord::Base

  validates :starts_at, :presence => true
  validates :ends_at, :presence => true

  validates :event, :presence => true

  belongs_to :event

  belongs_to :contact

  before_save :check_price

  before_update :check_token


  def free?
    !self.contact
  end

  private

  def check_token
    if !self.token && self.contact
      self.token = Random.rand(1000...10000).to_s
    end
  end

  def check_price
    if !self.price && self.event && self.event.service
      self.price = self.event.service.price
    end
  end

end
