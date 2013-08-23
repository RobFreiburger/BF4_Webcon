class Player < ActiveRecord::Base
	has_one :user

	# Name validation
	validates :name, presence: true, uniqueness: true
	validates :name, length: { in: 4..16 }
	validates :name, format: { with: /\A[A-Za-z0-9_-]{4,16}\z/ }
end