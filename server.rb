#!/usr/bin/env ruby -w
require "socket"
require_relative 'color'
require_relative 'question'
require_relative 'player'
require_relative 'game'


class Server
  attr_accessor(:connections)
  def initialize
    port = rand(1000...9999)
    addr_infos = Socket.ip_address_list
    ip =  addr_infos[1].ip_address
    puts "#{ip}::#{port}"
    @server = TCPServer.open( ip, port )
    @connections = Hash.new
    @rooms = Hash.new
    @clients = Hash.new
    @connections[:server] = @server
    @connections[:rooms] = @rooms
    @connections[:clients] = @clients
    run
  end

  def run
    loop {
      Thread.start(@server.accept) do | client |
        nick_name = client.gets.chomp.to_sym
        @connections[:clients].each do |other_name, other_client|
          if nick_name == other_name || client == other_client
            client.puts "This username already exist"
            Thread.kill self
          end
        end
        puts "#{nick_name} has connected..."
        @connections[:clients][nick_name] = client
          if @connections[:clients].length == 1
            $game.start_player1(nick_name)
            $client1 = client
            client.puts "Waiting for Player 2..."
          elsif @connections[:clients].length == 2
            $game.start_player2(nick_name)
            $client2 = client
            $game.start
          else
            client.puts "GOAWAY. killing thread"
            client.abort
            Thread.kill self
          end

      end
    }.join
  end

end
$client1 = nil
$client2 = nil
$game = Game.new
Server.new

