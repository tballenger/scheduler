class XeroSessionController < ApplicationController
  before_filter :get_xero_client

  def new
    session[:user_name] = params[:user_name] if params[:user_name].present?
    request_token = $xero.request_token(:oauth_callback => 'http://localhost:3000/xero_session/create')
    session[:request_token] = request_token.token
    session[:request_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def create
    $xero.authorize_from_request(
        session[:request_token],
        session[:request_secret],
        :oauth_verifier => params[:oauth_verifier] )

    session[:xero_auth] = {
        :access_token => $xero.access_token.token,
        :access_key => $xero.access_token.secret }

    session.delete(:request_token)
    session.delete(:request_secret)
    redirect_to synchronize_contacts_path
  end

  def destroy
    session.delete(:xero_auth)
    redirect_to root_path
  end

end
