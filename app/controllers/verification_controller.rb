class VerificationController < ApplicationController
	before_action :signed_in_user
	before_action :is_unverified

  def start
  	@expected_token = current_user.verification_token
  end

  def complete
    profile_url = params.require(:profile_url)
    regex_pattern = /\Ahttp:\/\/forums\.somethingawful\.com\/member\.php\?action=getinfo&userid=\d+\z/

    if !profile_url.match(regex_pattern)
      flash[:error] = "Profile URL is't correct. Must look like http://forums.somethingawful.com/member.php?action=getinfo&userid=####"
      redirect_to action: 'start'
    else
      expected_token = current_user.verification_token

      if verify_profile(profile_url, expected_token)
        current_user.profile_id = profile_url.match(/\d+\z/).to_s.to_i
        current_user.is_verified = true
        current_user.save
        flash[:success] = "You're now verified. Enjoy!"
        redirect_to(root_url)
      else
        flash[:error] = "Did not find #{expected_token} in the Occupation field."
        redirect_to action: 'start'
      end
    end
  end

  private

  def is_unverified
  	redirect_to(root_url) if current_user.is_verified?
  end

  def verify_profile(url, string)
  end

end
