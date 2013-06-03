
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
    message.headers['name'] = session[:name]
    message.headers['id'] = session.id
    puts "got a message, sneding it on: #{message.inspect}"
    send_to( @responses, message )
  end

end
