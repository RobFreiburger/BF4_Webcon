class Player < ActiveRecord::Base
	self.primary_key = 'guid'
	has_one :user

	# GUID validation
	validates :guid, uniqueness: true
	validates :guid, length: { in: 1..32 }
	validates :guide, format: { with: /\A[0-9A-Fa-f]{1,32}\z/ }

	# Name validation
	validates :name, presence: true, uniqueness: true
	validates :name, length: { in: 4..16 }
	validates :name, format: { with: /\A[A-Za-z0-9_-]{4,16}\z/ }
end