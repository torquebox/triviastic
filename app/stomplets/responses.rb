
require 'torquebox-stomp'

class Responses 
 
  def configure(opts={})
    @subscribers = []
  end

  def on_subscribe(subscriber)
    if ( subscriber.session[:host] )
      @subscribers << subscriber
    end
  end

  def on_message(message, session)
    message.headers['name'] = session[:name]
    message.headers['id'] = session.id
    @subscribers.each do |s|
      s.send( message )
    end
  end

end
