desc "BF4 Server Manager"
task bf4_server_manager: :environment do
	all_servers = Server.all
	array = []

	all_servers.each_index do |i|
		s = all_servers[i]
		array[i] = BFClient.new(host: s.ip_address, port: s.rcon_port, password: s.rcon_pw)
		array[i].manage_and_log_server
	end
end