require "socket"

def log(*args)
  puts args
end

class ChatServer
  attr_accessor :port
  
  def initialize(some_port)
    self.port = some_port
    @sockets = {}
  end 

  def run
    log "Starting Chatte server..."
    Socket.tcp_server_loop(self.port) { |sock, client_addrinfo|
      log "Received connection. Starting one thread..."
      Thread.new do
        begin
          nick = ""
          log "Thread started."
          nick = read_nickname(sock)
          log "Storing socket for #{nick}..."
          @sockets[nick] = sock
          main_loop(sock, nick)
        rescue => e
          log "Exception raised: #{e}"
        ensure
          log "Closing socket."
          @sockets.delete(@sockets.key(sock))
          sock.close
          log "Socket closed."
        end
      end 
    }
  end
  
  private
  
  def read_nickname(socket)
    socket.puts "0 Hello, nickname please."
    nick = socket.readline.chomp
    if nick =~ /\A[a-z0-9\._+-]+\z/i
      socket.puts "200 Welcome to the chatte." 
    else
      socket.puts "201 Invalid nickname. Please try again. Bye."
      raise Exception.new("Invalid nickname #{nick}")
    end
    log "Got the nickname of the new connection. It's '#{nick}'"
    if @sockets.include?(nick)
      socket.puts "202 Nickname already in use. Please try with another one. Bye." 
      raise Exception.new("Nickname #{nick} already taken")
    end
    nick
  end
  
  def main_loop(socket, nickname)
    log "main loop for '#{nickname}'"
    while not socket.eof?
      line = socket.readline.chomp
      unless line =~ /(100|101|102)\ (.*)/
        socket.puts "666 Invalid command. Ignoring."
        next 
      end

      if $1 == "100"
        message = $2
        @sockets.each do |other_nickname, other_socket|
          other_socket.puts "100 #{nickname} #{message}"
        end
        socket.puts "101 Message sent."
      elsif $1 == "101"
        # The client received the message. Great!
      elsif $1 == "102"
        unless line =~ /102\ ([^\s]+)\s(.+)/
          socket.puts "666 Invalid command. Ignoring."
          next
        end
        destinatary = $1
        message = $2
        unless @sockets.include?(destinatary)
          socket.puts "203 Invalid destinatary. Verify the nickname."
          next
        end
        @sockets[destinatary].puts "102 #{destinatary} #{message}"
        socket.puts "101 Message sent."
      end
    end
  end
end


server = ChatServer.new(1234)
server.run
