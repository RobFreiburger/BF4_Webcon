class Server < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :guid, uniqueness: true, allow_blank: true
	validates :ip_address, uniqueness: true, allow_blank: true
	validates :rcon_port, allow_blank: true, numericality: { 
		only_integer: true, 
		greater_than: 0,
		less_than_or_equal_to: 65535
	}
end