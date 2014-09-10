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
elsif input == "POST"
	print 'Please enter your name: '
	name = gets.chomp
	print 'Please enter your email: '
	email = gets.chomp

	content = {:person => {:name => name, :email => email}}.to_json

	request = "POST #{file_path} HTTP/1.0\nContent size: #{content.size} \r\n\r\n#{content}"
end

#connect to socket

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read

headers, body = response.split("\r\n\r\n", 2)
print body
socket.close