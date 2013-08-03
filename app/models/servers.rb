require 'ipaddr'

class Servers < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false }

	validates :rcon_port, length: { in: 1..5 }
	validates :rcon_port, numericality: {
		only_integer: true,
		greater_than: 0,
		less_than: 65537
	}

	validates :allow_use, inclusion: { in: [true, false] }
end

class 