require 'openid'

class SessionsController < ApplicationController
  def new
  	oidreq = consumer.begin('http://steamcommunity.com/openid')
  	realm = url_for action: 'create', only_path: false
  	redirect_to oidreq.redirect_url(realm, realm)
  end

  def create
  	current_url = url_for action:'create', only_path: false
    parameters = params.permit!.delete_if { |k,v| !k.starts_with?('openid') }
  	oidresp = consumer.complete(parameters, current_url)

    # Complete OpenID request
  	case oidresp.status
  	when OpenID::Consumer::FAILURE
  		flash[:error] = "Verification failed: #{oidresp.message}"
      redirect_to root_path
  	when OpenID::Consumer::SETUP_NEEDED
  		flash[:alert] = 'Immediate request failed - Setup Needed.'
      redirect_to root_path
  	when OpenID::Consumer::CANCEL
      flash[:alert] = 'OpenID transaction cancelled.'
      redirect_to root_path
    when OpenID::Consumer::SUCCESS
      steam_id = oidresp.display_identifier.match(/\d+\z/).to_s.to_i
      user = User.find(steam_id)

      # Create user if needed
      if user == ActiveRecord::RecordNotFound
        user = User.create(steam_id: steam_id, is_admin: false)
      end

      sign_in user
      redirect_to root_path
    end
  end

  def destroy
  end
end
