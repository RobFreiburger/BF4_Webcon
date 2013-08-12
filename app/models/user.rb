class User < ActiveRecord::Base
	@@primary_key = 'steam_id'

	# Steam ID validations
	validates :steam_id, presence: true, uniqueness: true, 
	numericality: { 
		only_integer: true,
		greater_than: 0 
	}

	# Admin validation
	validates :is_admin, presence: true, inclusion: { in: [true, false] }

end