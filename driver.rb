# ruby port scanner code
require 'socket'
require 'os'

entries = {
  'port_start': "119",
  'port_end': "8281",
  'target': "127.0.0.1"
}

class PortScan
  attr_accessor :port_start, :port_end, :target

  def initialize(port_start, port_end, target="127.1.1.1")

    self.port_start = port_start
    self.port_end   = port_end || 8080
    self.target     = target if target
  end

  def validate? 
    puts "yeah"
    return true
  end

  def print_ports
    puts self.port_start
    puts self.port_end
    puts self.target if self.target

  end

  def scan_target
    return "scanning target"
  end
end

io = PortScan.new(1, 20)
str_arr = []
io.validate?
io.print_ports
puts "pre"
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
puts "begin"
puts str_arr
puts "end"
str_arr = ""
puts str_arr + "end code"

io = PortScan.new(entries[:port_start], entries[:port_end], entries[:target])
io.print_ports

## J .Campbell SID : ##