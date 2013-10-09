desc "BF4 Server Manager"
task bf4_server_manager: :environment do
	array = []
	Server.all.each_index do |s, i|
		array[i] = BFClient.new(host: s.ip_address, port: s.port_num, password: s.password)
		array[i].manage_and_log_server
	end
end