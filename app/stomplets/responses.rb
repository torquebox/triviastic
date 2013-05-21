
require 'torquebox-stomp'

class Responses < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @responses = TorqueBox.fetch( '/topics/responses' )
  end

  def on_subscribe(subscriber)
    subscribe_to( subscriber, @responses )
  end

  def on_message(message, session)
    puts "got a message, sneding it on"
    message.headers['name'] = session[:name]
    message.headers['id'] = session.id
    send_to( @responses, message )
  end

end
