#!/usr/bin/env ruby -w
require "socket"
class Client
  def initialize
    puts "input ip address(ip::port) "
    input = gets.chomp
    address = input
    ip = address.split("::")[0]
    port = address.split("::")[1]
    server = TCPSocket.open( ip, port )
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end

  def listen
    @response = Thread.new do
      loop {
        msg = @server.gets.chomp
        puts "#{msg}"

        if msg == "GOAWAY. killing thread" || msg == "This username already exist"
          abort
        end
      }
    end
  end

  def send
    @request = Thread.new do
      puts "enter your name: "
      loop {
        msg = $stdin.gets.chomp
        @server.puts( msg )
      }
    end
  end
end
Client.new