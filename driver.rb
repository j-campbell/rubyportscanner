# ruby port scanner code
require 'socket'
# require 'os'

# def brick_breaker str
#   str = str.split '#'
# end

def brick_breaker str_in
  # str_in = str_in[0]
  # str_in.remove('[', ']')
  # status = str_in.split('#')[0]
  # puts str_in
  str_in.split('#')
end

@entries = {
  'port_start': "20",
  'port_end': "30",
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
    return str_arr[0]
  end

  def tcp_socket host, port
    out = []
    begin
      socket = TCPSocket.new(host, port)
      out << "#{host}:#{port}#open"
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      out << "#{host}:#{port}#closed"
    end
  end
end

io = PortScan.new(@entries[:port_start],@entries[:port_end])


rts = io.scan_target
# rts.each {|e|}
# rts.inspect


# io = PortScan.new("20",@entries[:port_end], "8.8.8.8")
# puts rts
# puts rts.to_s + "<<<<"
rts.flatten!
# puts rts
s_out = (brick_breaker rts[0])
puts s_out[1]
# puts s_out[0]
# puts " <<<< "
# io.each {|i| puts i} # io is an object not a collection class

