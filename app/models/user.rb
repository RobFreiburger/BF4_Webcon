class User < ActiveRecord::Base
	@@primary_key = 'steam_id'

	# Steam ID validations
	validates :steam_id, presence: true, uniqueness: true, 
	numericality: { 
		only_integer: true,
		greater_than: 0,
		less_than: 2 ** 64
	}

	# Admin validation
	validates :is_admin, inclusion: { in: [true, false] }

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

end