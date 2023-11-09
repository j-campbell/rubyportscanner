# ruby port scanner code
# j. campbell 881298169
require 'socket' # TCP library for Ruby

# Flattens the array output from PortScan
def brick_breaker str_in
  str_in = str_in[2..-3]   # strip first 2 and last 2 characters
  k = str_in.split('#')    # 
  return k
end

# Performs a count of open ports vs closed ports
# Creates a pretty message to append to overall output
def port_count scan_res
  cnt = 0
  scan_res.each do |s|
    cnt+=1 if s[1] == "open"
  end
  return ">> #{scan_res.length} ports scanned :: #{cnt} port open <<"
end

# make output more human readable
def prettify scan_in
  return "Scan Target :: #{scan_in[0]} - status :: #{scan_in[1]}"
end

class PortScan
  attr_accessor :port_start, :port_end, :target

  # development environment -- turn off $TARGET default and change to *optional for production
  #
  # Initializer for PortScan Class, default to local host of no target supplied
  def initialize(port_start, port_end, target="127.0.0.1")

    self.port_start = port_start.to_i
    self.port_end   = port_end.to_i
    self.target     = target
  end

  # SCAN_TARGET
  #
  # Inputs : none - uses class attributes
  #
  #
  def scan_target 
    str_arr = []
    f_port, l_port = self.port_start, self.port_end    
    str_arr = (f_port..l_port).collect {|p| tcp_socket(self.target, p).to_s }
    return str_arr
  end

  # TCP_SOCKET subroutine 
  #
  # Inputs : host - IP Address of target
  #        : port - port to be scanned
  #
  # Checks to see if a socket will accept a TCP connection 
  def tcp_socket host, port
    out = []
    begin
      socket = TCPSocket.new(host, port)
      out << "#{host}:#{port}#open"
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      out << "#{host}:#{port}#closed"
    end
    return out
  end
end

### Main Program Logic - called from GUI or CLI
def run_scan # p_start, p_end, ip_target
  io = PortScan.new("4", "30", "127.0.0.1")     # create PortScan Object
  rts = io.scan_target                          # ready to scan
  rts_out =  rts.collect {|o| brick_breaker o}  # clean up output from scan
  cnt_str = port_count rts_out                  # count open ports
  rts_out =  rts_out.collect  {|o| prettify o}  # make output look nice
  rts_out << cnt_str                            # add scan summary
  # join array elements into multiline string
  rts_out = rts_out.join("\n")                  
  return rts_out
end
