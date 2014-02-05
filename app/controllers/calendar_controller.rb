class CalendarController < ApplicationController
  def index
    @event = Event.find(session[:event_id_selected]) if session[:event_id_selected].present?
  end
end
