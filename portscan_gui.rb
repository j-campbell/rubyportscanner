require 'glimmer-dsl-libui'

class PortScanner
  include Glimmer

  attr_accessor :text_box, :target, :first_port, :last_port

  def initialize
    self.text_box = "No data"
    self.target = "no target"
    self.first_port = "0"
    self.last_port = "1024"
  end

  def launch
    window("Port Scanner", 300, 600) {
      margined true
      vertical_box {
        form {
          entry {
            label "Target IP/URL"
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
          combobox {
            label "Mode"
            items ["select mode", "one", "two"]
            selected 2
          }
        }

        button("Scan") {
          on_clicked do
            s = "\
Scanning #{@target}
Ports #{@first_port} through #{@last_port}
adfasdf #-------- 
asdf
asdfasdf
asdfasdfasdf
asdfasdfasdf
asdfasdfasdfasd
asdfasdfas
asdfasdfasdfasdfa
asdfasdfasdfasdfasdfasdfasdfasdf
            "
            puts s
            self.text_box = s
          end
        }
        
        vertical_box {
          multiline_entry {  
            text <=> [self, :text_box]
          }
        }

        horizontal_box {
          button('Saved') {
            puts @entry_text

            on_clicked do
              self.text_box = 'Saved!'
            end
          }
          button('Clear') {

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
