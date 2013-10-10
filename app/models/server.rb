class Server < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :guid, uniqueness: true, allow_blank: true
	validates :ip_address, uniqueness: true, allow_blank: true
	validates :rcon_port, allow_blank: true, numericality: { 
		only_integer: true, 
		greater_than: 0,
		less_than_or_equal_to: 65535
	}

	def rcon_pw
		# Retrieve :rcon_pw and decrypt
		decipher = OpenSSL::Cipher::AES.new(256, :CBC)
		decipher.decrypt
		decipher.iv = ENV['SERVER_PW_IV']
		decipher.key = ENV['SERVER_PW_KEY']
		encrypted = read_attribute(:rcon_pw)
		decipher.update(encrypted) + decipher.final
	end

	def rcon_pw=(new_pw)
		if new_pw.is_a?(String) && new_pw.present?
			# Encrypt new_pw and store in DB
			cipher = OpenSSL::Cipher::AES.new(256, :CBC)
			cipher.encrypt
			cipher.iv = ENV['SERVER_PW_IV']
			cipher.key = ENV['SERVER_PW_KEY']
			encrypted = cipher.update(new_pw) + cipher.final
			write(:rcon_pw, encrypted)

			# Return nothing
			return
		end
	end
end