class Event < ActiveRecord::Base

  validates :title, :presence => true
  validates :service_id, :presence => true

  belongs_to :service

  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  before_validation :check_and_set_title

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
        :id => self.id,
        :title => get_title(options) ,
        :description => self.description || "",
        :start => starts_at.rfc822,
        :end => ends_at.rfc822,
        :allDay => self.all_day,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.event_path(id)
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def get_title(options = {})
    if options[:event_id_selected] == self.id
      return "[#{self.title}]"
    end
    self.title
  end

  # When admin create a new events for more than a hour, we need to generate all slots (multiple vents) availables
  def create_slots
    if !(self.starts_at < self.ends_at)
      raise 'Error, ends at should be greater that starts at' #TODO: move to a class validation
    end
    hour = self.starts_at
    end_time = self.ends_at

    while hour < end_time
      puts hour
      Event.create!(:starts_at=> hour, :ends_at => hour + 1.hour, :service => self.service )
      hour += 1.hour
    end

    return true

  end


  private
  def check_and_set_title
    if self.title.blank? && self.service
      self.title = self.service.name
    end
  end

end
