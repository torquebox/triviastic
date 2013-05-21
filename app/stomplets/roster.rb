
require 'torquebox-stomp'

class Roster < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @roster = TorqueBox.fetch( '/topics/roster' )
  end

  def on_subscribe(subscriber)
    subscribe_to( subscriber, @roster, nil, :encoding=>:json )    
  end


end
