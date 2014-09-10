require 'socket' #socket library
require 'json' #json library

server = TCPServer.open(2000) #Bind server to port 2000

loop do
	Thread.start(server.accept) do |client| #usable for serving multiple clients

		request = client.read_nonblock(256) 
		header, body = request.split("\r\n\r\n", 2)
		file_path = header.split[1][1..-1] #get path from request header


		if File.exists?(file_path) #if file exists
			response = File.read(file_path)
			if header.start_with? 'GET'
				client.puts("GET #{file_path} HTTP/1.0 200 OK")
				client.puts("Content size: #{File.size(file_path)}\r\n\r\n}")
				client.puts response
			elsif header.include? 'POST'
				params = JSON.parse(body)
				info = "<li>Name: #{params['person']['name']}</li><li>Email: #{params['person']['email']}</li>"
				client.puts("POST #{file_path} HTTP/1.0 200 OK")
				client.puts("Content size: #{File.size(file_path)}\r\n\r\n}")
				client.puts response.gsub("<%= yield %>", info)

			else
				client.puts "Unknown request error"
			end
		else #if file does not exist
			client.puts("HTTP/1.0 404 Not Found\r\n\r\n")
		end
		client.close
	end
end