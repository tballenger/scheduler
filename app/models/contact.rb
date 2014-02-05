class Contact < ActiveRecord::Base
  validates :full_name, presence: true
  validates :last_name, presence: true
end
