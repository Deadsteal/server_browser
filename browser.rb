require 'socket'
require 'json'

hostname = 'localhost'
port = 2000

puts "Do you want to GET or POST?"
input = gets.chomp.upcase
puts "Enter the file path."
file_path = gets.chomp.downcase

if input == "GET"
	request = "GET #{file_path} HTTP/1.0\r\n\r\n"
end

#connect to socket

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read

headers, body = response.split("\r\n\r\n", 2)
print body
socket.close