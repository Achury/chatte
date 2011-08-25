#!/usr/bin/env ruby
require 'timeout'
require 'socket'

def log(*args)
  puts args
end


class ChatClient

  attr_accessor :ip, :port, :nickname

  def initialize(ip, port, nickname)
    self.ip = ip
    self.port = port
    self.nickname = nickname
  end
  
  def run
    log "Opening socket..."
    @socket = TCPSocket.new(ip, port)
    log "...opened."
    begin
      line = ""
      timeout(5) do
        line = @socket.gets.chomp
      end
      invalid_response! if not line =~ /0\s.+/
      @socket.puts nickname
      line = @socket.gets.chomp
      if line =~ /(201|202)\s(.+)/
        puts $2
        exit
      end
      # Connected, let's start the threads
      thread1 = Thread.new { read_from_server_thread }
      thread2 = Thread.new { write_to_server_thread }
      
      thread1.join
      thread2.join
      
    rescue Timeout::Error
      log "Timed out!"
      invalid_response!
    ensure
      @socket.close
    end
  end
  
  private
  
  def read_from_server_thread
    begin
      loop do
        line = @socket.gets.chomp
        if line =~ /100\s([^\s]+)\s(.+)/
          show_public_message($1, $2)
        elsif line =~ /102\s([^\s]+)\s(.+)/
          show_private_message($1, $2)
        elsif line =~ /(150|151|203)\s(.+)/
          show_server_notice($2)
        end
      end
    rescue Exception => e
      log "Exception raised while reading from server: #{e}"
    end
  end
  
  def write_to_server_thread
    begin
      loop do
        line = STDIN.gets.chomp
        if line =~ /\/whisper/
          if line =~ /\/whisper\s([^s]+)\s(.+)/ # private message
            send_private_message($1, $2)
          else
            puts "Usage: /whisper <nickname> <message>"
          end
        else
          send_public_message(line)
        end
      end
    rescue Exception => e
      log "Exception raised while writing to server: #{e}"      
    end
  end
  
  def send_public_message(message)
    @socket.puts "100 #{message}"
  end
  
  def send_private_message(to, message)
    @socket.puts "102 #{to} #{message}"    
  end
  
  def show_public_message(from, message)
   STDOUT.puts "#{from} says: '#{message}'"    
  end
  
  def show_private_message(from, message)
    STDOUT.puts "#{from} whispers: '#{message}'"
  end
  
  def show_server_notice(notice)
    STDOUT.puts notice
  end
  
  def invalid_response!
    log "Server is not responding appropriately. Are you sure this is a chatte server?"
    throw Exception.new("Invalid server response")
  end
end


if ARGV.size < 2
  puts "Usage: ruby #{__FILE__} [host] [port]"
else
  puts "Enter your nickname:"
  n = STDIN.gets.chomp
  
  client = ChatClient.new(ARGV[0], ARGV[1].to_i, n)
  client.run
end
