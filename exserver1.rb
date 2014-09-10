require 'socket' #socket library
require 'json' #json library

server = TCPServer.open(2000) #Bind server to port 2000

#need a loop of some kind
loop do
	Thread.start(server.accept) do |client| #usable for serving multiple clients

		request = client.read_nonblock(256) #read the request from the client and store it in the request variable
		header, body = request.split("\r\n\r\n", 2)#split request into header and body (two line breaks and then max limit of 2)
		file_path = header.split[1][1..-1] #get path from request header


		if File.exists? file_path #if file exists
			body = File.read(file_path)
			client.puts "GET #{filepath} HTTP/1.0 200 OK\r\n"
			client.puts "Content size: #{File.size(file_path)}\r\n\r\n}"
			if header.start_with? 'GET'
				client.puts body
			else
				client.puts "Unknown request error"
			end
		else #if file does not exist
			client.puts "HTTP/1.0 404 Not Found\r\n\r\n"
		end
		client.close
end