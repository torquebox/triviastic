
require 'torquebox-stomp'
require 'json'

class Control < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @hosts = []
    @control = TorqueBox.fetch( '/topics/questions' )
  end

  def on_subscribe(subscriber)
    @hosts << subscriber
  end

  def on_message(message, session)
    puts "#{self} message => #{message.inspect}"
    q = next_question()
    @hosts.each do |h|
      puts "sending to host #{h}"
      h.send( TorqueBox::Stomp::Message.new( JSON.unparse( q ) ) )
    end
    q.delete( :answer )
    send_to( @control, q, {}, :encoding=>:json )
  end

  def next_question() 
    { :question=>'What is the thing?', :answer=>'a cat' }
  end

end
