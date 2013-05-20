
require 'torquebox-stomp'

class Control < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @control = TorqueBox.fetch( '/topics/questions' )
  end

  def on_subscribe(subscriber)
  end

  def on_message(message, session)
    puts "#{self} message => #{message.inspect}"
    q = next_question()
    send_to( @control, q, {}, :encoding=>:json )
  end

  def next_question() 
    { :question=>'What is the thing?' }
  end

end
