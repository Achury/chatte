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
    socket.puts "Hello client. Please write your nickname."
    nick = socket.readline.chomp
    if nick =~ /\A[a-z0-9\._+-]+\z/
      socket.puts "Hello #{nick}. Welcome to the chat."
    else
      socket.puts "Invalid nickname. Please try again. Bye."
      raise Exception.new("Invalid nickname #{nick}")
    end
    log "Got the nickname of the new connection. It's '#{nick}'"
    nick
  end
  
  def main_loop(socket, nickname)
    log "main loop for '#{nickname}'"
    while not socket.eof?
      line = socket.readline.chomp
      log "#{nickname} said: #{line}"
      @sockets.each do |other_nickname, other_socket|
        other_socket.puts "#{nickname} said: #{line}"
      end
    end
  end
end


server = ChatServer.new(1234)
server.run
