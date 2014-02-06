class CalendarController < ApplicationController
  def index
    begin
      @event = Event.find(session[:event_id_selected]) if session[:event_id_selected].present?
      @time_slot = TimeSlot.find(session[:time_slot_id_selected]) if session[:time_slot_id_selected].present?
    rescue
      session[:event_id_selected] = nil
      session[:time_slot_id_selected] = nil
    end
  end
end
