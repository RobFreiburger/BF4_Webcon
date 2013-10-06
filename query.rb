require_relative 'lib/bf_connection.rb'

hosts = {
	:test => {
		:host => ENV['BFHOST'],
		:port => ENV['BFPORT'],
		:pass => ENV['BFPASS'],
	},
	:test2 => {
		:host => ENV['BFHOST'],
		:port => ENV['BFPORT'],
		:pass => ENV['BFPASS'],
	}
}
clients = {}

class BFClient
	attr_accessor :connection

	def initialize(host)
		self.connection = EventMachine.connect(host[:host], host[:port], BFConnection) { |conn|
			conn.password = host[:pass]
		}
	end

end

EventMachine.run {
	hosts.each { |name, host|
		clients[name] = BFClient.new(host)
	}
}
