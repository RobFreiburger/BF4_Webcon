require 'openid'

class SessionsController < ApplicationController
	layout false

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
		when OpenID::Consumer::SETUP_NEEDED
			flash[:alert] = 'Immediate request failed - Setup Needed.'
		when OpenID::Consumer::CANCEL
			flash[:alert] = 'OpenID transaction cancelled.'
		when OpenID::Consumer::SUCCESS
			steam_id = oidresp.display_identifier.match(/\d+\z/).to_s.to_i
			user = User.find_by(steam_id: steam_id)

			debugger

			# Create user if needed
			if user.nil?
				user = User.create(steam_id: steam_id)
			end

			# Sign in and notify
			sign_in(user)
			flash[:success] = "You're signed in."
		end

		redirect_to root_path
	end

	def destroy
		sign_out
		flash[:alert] = "You're signed out."
		redirect_to root_path
	end

	private

	def consumer
		if @consumer.nil?
			@consumer = OpenID::Consumer.new(session, nil)
		end

		@consumer
	end
end
