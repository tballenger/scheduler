module ApplicationHelper
  def parse_datetime(date_and_time)
    if date_and_time
      date_and_time.in_time_zone('Pacific Time (US & Canada)').strftime("%b %e, %Y %l:%M %P")
    end
  end

  def parse_time(date_and_time)
    if date_and_time
      date_and_time.in_time_zone('Pacific Time (US & Canada)').strftime("%l:%M %P")
    end
  end
end
