# ruby port scanner code
require 'socket'
# require 'os'

@entries = {
  'port_start': "20",
  'port_end': "1024",
  'target': "192.168.0.1"
}

class PortScan
  attr_accessor :port_start, :port_end, :target

  # development environment -- turn off $TARGET default and change to *optional for production
  def initialize(port_start, port_end, target="127.0.0.1")

    self.port_start = port_start.to_i
    self.port_end   = port_end.to_i
    self.target     = target
  end

  # def validate?         # write once core code works for valid inputs
  #   puts "yeah"
  #   return true
  # end

  # def print_ports       # debug method
  #   # puts self.port_start
  #   # puts self.port_end
  #   # puts self.target if self.target

  # end

  def scan_target 
    str_arr = []
    f_port, l_port = self.port_start, self.port_end
    # puts f_port, l_port, target
    # puts "debug mode><><"
    # (f_port..l_port).each {|p| puts p}
    str_arr << (f_port..l_port).map {|p| tcp_socket(self.target, p) }
    return str_arr
  end

  def tcp_socket host, port
    out = []
    begin
      socket = TCPSocket.new(host, port)
      out << "#{host}:#{port}#open"
      # out << [host: {port: "1"}]
      # puts out
      # out
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      # status = "closed"
      out << "#{host}:#{port}#closed"
      # out << {"#{host}:#{port}": status="closed"}
      # out << [host: {port: "1"}]
      # out << 'e'
    end
  end
end

io = PortScan.new(@entries[:port_start],@entries[:port_end])

# rts = []
# rts << io.scan_target
# rts.each {|e|}
# rts.inspect


# io = PortScan.new("20",@entries[:port_end], "8.8.8.8")
# puts rts
# puts " <<<< "
# io.each {|i| puts i} # io is an object not a collection class

def brick_breaker
end