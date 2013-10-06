require 'eventmachine'
require 'digest'
require_relative 'bf_protocol.rb'

class BFConnection < EventMachine::Connection
  include BFProtocol
  attr_accessor :sequence, :blocks, :state
  
  def post_init
    sequence = 0
    @state = :preauth
    blocks = {}
    @receive_buffer = ''
    
    send_data('login.hashed')
  end

  def receive_data(data)
  	puts "< data: #{data}"
		@receive_buffer += data

		while contains_complete_packet(@receive_buffer)
		  packet_size = decode_int32(@receive_buffer[4...8])
			packet = @receive_buffer[0...packet_size]
			@receive_buffer = @receive_buffer[packet_size..@receive_buffer.size]
      
      is_from_server, is_response, sequence, words = decode_packet(packet)
      
      puts "state: #{state}"
      case @state # TODO: Figure out why state == nil
      else
        dispatch_handler(is_from_server, is_response, sequence, words)
      end
		end
	end

  def dispatch_handler(is_from_server, is_response, sequence, words)
    puts "#{is_from_server}, #{is_response}, #{sequence}, #{words}"
  end

	def send_data(*data)
		packet = encode_client_request(*data)
		puts "> data: #{packet}"
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

EventMachine.run {
	EventMachine.connect '', 0, BFConnection
}
