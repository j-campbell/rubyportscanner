require 'nmap/command'
require 'stringio'

class PortScannerController

  attr_accessor :target, :first_port, :last_port, :flag_string

  def initialize
  end

  def validate_inputs
  end

  def run_scan 
    txt = []
    txt << Nmap::Command.run do |nmap|
      nmap.connect_scan = true
      nmap.service_scan = true
      # nmap.verbose = true

      nmap.ports = [20, 21, 22, 23, 25, 80, 8080]
      nmap.targets = '127.0.0.1'
    end
    return txt.join("\n")
  end
end

def capture_output
  restore = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure  
  $stdout = restore
end

txt = capture_output { PortScannerController.new.run_scan }

puts "before"
puts txt
puts "after"