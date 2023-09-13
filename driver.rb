# ruby port scanner code
require 'socket'
require 'os'

class PortScan
  attr_accessor :port_start, :port_end

  def initialize(port_start, port_end)
    self.port_start = port_start
    self.port_end   = port_end
  end

  def validate? 
    puts "yeah"
    return true
  end

  def print_ports
    puts self.port_start
    puts self.port_end
  end

  def scan_target
    "scanning target"
  end
end

io = PortScan.new(1, 20)
str_arr = []
io.validate?
io.print_ports
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
str_arr << io.scan_target
puts str_arr