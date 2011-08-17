require "socket"


class ChatServer
  attr_accessor :port 

  def initilize(port)
    self.port = port
    @sockets = {}

  end 

  def run 
    Socket.tcp_server_loop(self.port) { |sock, client_addrinfo|
      Thread.new do
        begin
          puts "Received connection"
          puts client_addrinfo
          @sockets[rand(10000)] = sock
          IO.copy_stream(sock, sock)          
        ensure
          sock.close
        end
      end 
    }
  end 
end


server = ChatServer.new(1234)
server.run
