
require 'torquebox-stomp'

class Responses < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @responses = TorqueBox.fetch( '/queues/responses' )
  end

  def on_subscribe(subscriber)
    subscribe_to( subscriber, @responses )
  end

  def on_message(message, session)
    send_to( @responses, message )
  end

end
