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

  private
  def check_and_set_title
    if self.title.blank? && self.service
      self.title = self.service.name
    end
  end

end
