
require 'torquebox-stomp'

class Questions < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @questions = TorqueBox.fetch( '/topics/questions' )
  end

  def on_subscribe(subscriber)
    puts "subcribe to /questions #{subscriber}"
    subscribe_to( subscriber, @questions, nil, :encoding=>:json )    
  end


end
