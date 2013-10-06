require 'digest'

module BFProtocol

	def decode_packet(data)
		is_from_server, is_response, sequence = decode_header(data)
		words_size = decode_int32(data[4...8]) - 12
		words = decode_words(words_size, data[12..data.length])
		[is_from_server, is_response, sequence, words]
	end

	def encode_request(sequence, *words)
		encode_packet(false, false, sequence, words)
	end

	def contains_complete_packet(data = '')
		if data.size < 8 || data.size < decode_int32(data[4...8])
			false
		else
			decode_int32(data[4...8])
		end
	end

	def generate_hashed_password(salt, password)
		m = Digest::MD5.new
		m.update(salt)
		m.update(password)
		m.hexdigest.upcase
	end

	private

		def encode_header(is_from_server, is_response, sequence)
			header = sequence & 0x3fffffff
			header += 0x80000000 if is_from_server
			header += 0x40000000 if is_response
			[header].pack('<I')
		end

		def decode_header(data)
			header = data[0...4].unpack('<I')[0]
			[header & 0x80000000, header & 0x40000000, header & 0x3fffffff]
		end

		def encode_int32(size)
			[size].pack('<I')
		end

		def decode_int32(data)
			data[0...4].unpack('<I')[0]
		end

		def encode_words(words)
			size = 0
			encoded_words = ''

			words.each do |word|
				word_size = word.size
				encoded_words += encode_int32(word_size)
				encoded_words += word
				encoded_words += "\x00"
				size += word_size + 5
			end

			[size, encoded_words]
		end

		def decode_words(size, data)
			words = []
			offset = 0

			while offset < size
				word_length = decode_int32(data[offset...(offset+4)])
				word = data[(offset + 4)...(offset + 4 + word_length)]
				words << word
				offset += word_length + 5
			end

			words
		end

		def encode_packet(is_from_server, is_response, sequence, words)
			encoded_header = encode_header(is_from_server, is_response, sequence)
			encoded_num_words = encode_int32(words.size)
			words_size, encoded_words = encode_words(words)
			encoded_size = encode_int32(words_size + 12)

			encoded_header + encoded_size + encoded_num_words + encoded_words
		end

end