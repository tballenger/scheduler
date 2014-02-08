class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :correct_safari_and_ie_accept_headers, :find_business
  after_filter :set_xhr_flash

  helper_method :get_business_name, :get_business_description

  def get_xero_client
    $xero = Xeroizer::PublicApplication.new(APP_CONFIG['OAUTH_CONSUMER_KEY'],APP_CONFIG['OAUTH_CONSUMER_SECRET'])

    # Add AccessToken if authorised previously.
    if session[:xero_auth]
      $xero.authorize_from_access(
          session[:xero_auth][:access_token],
          session[:xero_auth][:access_key] )
    end
  end

  def get_business_name
    @business && @business.business_name || 'Your Business'
  end

  def get_business_description
    @business && @business.business_description || 'Your Business Description'
  end

  private

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end

  def find_business
    begin
      session[:username] = params[:username] if params[:username].present?
      if session[:username].present?
        #try to find user with username
        @business = User.where(:username => session[:username]).first
      else
        #try to determinate if business is current user
        @business = current_user
      end
    rescue
      @business = nil
      session[:username] = nil
    end
  end

  def find_event_and_slot
    begin
      @event = Event.find(session[:event_id_selected]) if session[:event_id_selected].present?
      @time_slot = TimeSlot.find(session[:time_slot_id_selected]) if session[:time_slot_id_selected].present?
    rescue
      session[:event_id_selected] = nil
      session[:time_slot_id_selected] = nil
    end
  end


end
