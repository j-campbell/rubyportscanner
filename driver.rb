# ruby port scanner code
require 'socket'
# require 'os'

# def brick_breaker str
#   str = str.split '#'
# end

def brick_breaker str_in
  # puts "debug"
  str_in = str_in[2..-3]
  # str_in = str_in[0]
  # status = str_in.split('#')
  # puts 
  k = str_in.split('#')
  # puts k
  return k
#   str_in[0].join()
end

def port_count scan_res
  cnt = 0
  scan_res.each do |s|
    cnt+=1 if s[1] == "open"
  end
  return ">> #{scan_res.length} ports scanned :: #{cnt} port open <<"
end


def prettify scan_in
  return "Scan Target :: #{scan_in[0]} - status :: #{scan_in[1]}"
end

@entries = {
  'port_start': "20",
  'port_end': "40",
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

  def scan_target 
    puts "in scan"
    str_arr = []
    f_port, l_port = self.port_start, self.port_end
    # puts f_port, l_port, target
    # puts "debug mode><><"
    
    str_arr = (f_port..l_port).collect {|p| tcp_socket(self.target, p).to_s }

    # puts str_arr
    return str_arr
  end

  def tcp_socket host, port
    puts "socket"
    out = []
    begin
      socket = TCPSocket.new(host, port)
      out << "#{host}:#{port}#open"
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      out << "#{host}:#{port}#closed"
    end
    puts "out"
    return out
  end
end



def run_scan # p_start, p_end, ip_target
  puts "in driver"
  io = PortScan.new("20", "30", "127.0.0.1")
  puts io
  rts = io.scan_target
  # rts.each {|e|}
  # rts.inspect


  # io = PortScan.new("20",@entries[:port_end], "8.8.8.8")
  # puts rts
  # puts rts.to_s + "<<<<"
  # rts.flatten!
  # puts rts[0]
  puts rts
  # str_out = rts.collect {status}
  rts_out =  rts.collect {|o| brick_breaker o}
  cnt_str = port_count rts_out
  rts_out2 =  rts_out.collect  {|o| prettify o}
  rts_out2 << cnt_str
  rts_out3 =rts_out2.join("\n")
  puts rts_out
  puts rts_out2
  puts rts_out2.join.class
  # return rts_out2.join "\n"
  return rts_out3
end


# puts k =( brick_breaker (rts).each)
# puts s_out
# puts s_out[0]
# puts " <<<< "
# io.each {|i| puts i} # io is an object not a collection class


