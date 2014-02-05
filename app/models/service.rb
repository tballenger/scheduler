class Service < ActiveRecord::Base
  validate :name, presence: true
  validate :price, presence: true, numericality: true
  validate :minutes_duration, presence: true, numericality: true
end
