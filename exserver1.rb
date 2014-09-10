require 'socket' #socket library
require 'json' #json library

server = TCPServer.open(2000) #Bind server to port 2000

#need a loop of some kind
loop do
	Thread.start(server.accept) do |client| #usable for serving multiple clients

		request = client.read_nonblock(256) #read the request from the client and store it in the request variable

		if #file exists
		else #if file does not exist
		end
end