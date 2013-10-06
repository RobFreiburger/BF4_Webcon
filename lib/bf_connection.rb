require 'eventmachine'
require 'digest'
require_relative 'bf_protocol.rb'

class BFConnection < EventMachine::Connection
	include BFProtocol
	attr_accessor :sequence, :blocks, :state, :password, :handlers
	
	def post_init
		@sequence = 0
		@state = :preauth
		@blocks = {}
		@receive_buffer = ''
		
		send_data('login.hashed')
	end

	def receive_data(data)
		@receive_buffer += data

		while packet_size = contains_complete_packet(@receive_buffer)
			packet = @receive_buffer[0...packet_size]
			@receive_buffer = @receive_buffer[packet_size..@receive_buffer.size]
			
			is_from_server, is_response, sequence, words = decode_packet(packet)
			if handlers && handlers[:debug]
				handlers[:debug]['<', *words]
			end
			
			case @state
			when :preauth
				self.state = :authenticating
				self.send_data('login.hashed', generate_hashed_password([words[1]].pack('H*'), self.password))
			when :authenticating
				if words[0] == "OK"
					self.state = :postauth
					self.run_command('admin.eventsEnabled', 'true') {self.state = :connected}
				else
					close_connection
				end
			else
				dispatch_handler(is_from_server, is_response, sequence, words)
			end
		end
	end

	def dispatch_handler(is_from_server, is_response, sequence, words)
		if is_response and self.blocks[sequence]
			self.blocks[sequence].call(words)
		elsif handler = handlers[words[0]]
			handler[words]
		elsif handlers[:default]
			handlers[:default][words]
		end
	end

	def run_command(command, *parameters, &block)
		self.blocks[sequence] = block
		self.send_data(command, *parameters)
	end

	def send_data(*data)
		packet = encode_request(sequence, *data)
		if handlers && handlers[:debug]
			handlers[:debug]['>', *data]
		end
		self.sequence += 1
		super packet
	end
	
	def close_connection(*args)
		@intentionally_closed_connection = true
		super(*args)
	end

	def unbind
		@intentionally_closed_connection ||= false
		state = :disconnected
		puts "state: #{state}, intentionally_closed_connection: #{@intentionally_closed_connection}"
		# TODO: Investigate reconnecting
	end
end

