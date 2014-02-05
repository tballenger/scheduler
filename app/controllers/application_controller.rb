class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash



  def get_xero_client
    $xero = Xeroizer::PublicApplication.new(APP_CONFIG['OAUTH_CONSUMER_KEY'],APP_CONFIG['OAUTH_CONSUMER_SECRET'])

    # Add AccessToken if authorised previously.
    if session[:xero_auth]
      $xero.authorize_from_access(
          session[:xero_auth][:access_token],
          session[:xero_auth][:access_key] )
    end
  end

  private

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end
end
