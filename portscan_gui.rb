# gui written in the glimmer dsl
# using a ruby port of the libui cross platform gui library
require 'glimmer-dsl-libui'
require_relative 'driver.rb'

class PortScanner
  include Glimmer

  # used for bidirectional data binding with GUI inputs
  attr_accessor :text_box, :target, :first_port, :last_port

  def initialize
    self.text_box = "No data"
    self.target = "no target"
    self.first_port = "0"
    self.last_port = "1024"
  end

  def launch
    window("Port Scanner", 400, 600) {
      margined true # create auto margins
      vertical_box {
        form {
          # stretchy true # uncomment to allow resizing
          entry {
            label "Target IP/URL"
            # this bidirectional makes changes to a GUI element affect a 
            # variable and vice versa
            text <=> [self, :target]   
          }

          entry {
            label "Start Port"
            text <=> [self, :first_port]
          }

          entry {
            label "End Port"
            text <=> [self, :last_port]
          }
          # combobox {
          #   label "Mode"
          #   items ["select mode", "one", "two"]
          #   selected 0
          # }
        }

        button("Scan") {
          on_clicked do
            s = run_scan # calls main logic in driver.rb
            self.text_box = s
          end
        }
        
        vertical_box {
          # stretchy true
          multiline_entry {  
            text <=> [self, :text_box]
          }
        }

        horizontal_box {
          button('Saved') {
            # stretchy false

            on_clicked do
              self.text_box = 'Saved!' # @TODO write a function in driver
              puts @entry_text
              
            end
          }
          button('Clear') {
            # stretchy false

            on_clicked do
              self.text_box = ''
            end
          }
        }
      }
    }.show
  end
end

PortScanner.new.launch
