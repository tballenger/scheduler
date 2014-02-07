class CalendarController < ApplicationController
  def index
    begin
      if params[:service_id].present?
        session[:service_id_selected] = params[:service_id]
      end
      @service = Service.find(session[:service_id_selected]) if session[:service_id_selected].present?
      @event = Event.find(session[:event_id_selected]) if session[:event_id_selected].present?
      @time_slot = TimeSlot.find(session[:time_slot_id_selected]) if session[:time_slot_id_selected].present?
    rescue
      session[:service_id_selected] = nil
      session[:event_id_selected] = nil
      session[:time_slot_id_selected] = nil
    end
  end
end
