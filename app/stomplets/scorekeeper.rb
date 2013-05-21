
require 'torquebox-stomp'

class Scorekeeper < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @scores = {}
    @roster = TorqueBox.fetch( '/topics/roster' )
  end

  def on_subscribe(subscriber)
  end

  def on_message(message, session)
    current_score = @scores[ message.headers[:id] ] || 0
    current_score += 1
    @scores[ message.headers[:id] ] = current_score
    roster_update = {:name=>session[:name], :id=>session.id, :score=>current_score}
    puts "sending roster update #{roster_update.inspect}"
    send_to( @roster, roster_update, {}, :encoding=>:json )
  end

end
