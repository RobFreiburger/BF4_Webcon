class User < ActiveRecord::Base
	self.primary_key = 'steam_id'

	# Steam ID validations
	validates :steam_id, presence: true, uniqueness: true, 
	numericality: { 
		only_integer: true,
		greater_than: 0,
		less_than: 2 ** 64
	}

	# Admin validation
	validates :is_admin, inclusion: { in: [true, false] }

	# SA Forums Profile Verification validation
	before_create :create_verification_token
	validates :is_verified, inclusion: { in: [true, false] }
	validates :profile_id, uniqueness: true,
	numericality: {
		only_integer: true,
		greater_than_or_equal_to: 0
	}

	# Remember token
	before_create :create_remember_token

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end

	def create_verification_token
		self.verification_token = User.encrypt(User.new_remember_token)
	end

end