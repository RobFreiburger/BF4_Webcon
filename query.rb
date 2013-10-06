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
			conn.handlers = {
				'punkBuster.onMessage' => method(:punkbuster),
			}
		}
	end

	def run(command, *arguments, &blk)
		self.connection.run_command(command, *arguments, &blk)
	end

	def punkbuster(words)
		puts "Got punkbuster message!"
		puts words
	end

end

EventMachine.run {
	hosts.each { |name, host|
		clients[name] = BFClient.new(host)
	}
	EventMachine::Timer.new(5) { clients[:test2].run('serverinfo') {|words|
		puts "Got the result of 'serverinfo'"
		puts words
	}}
}
