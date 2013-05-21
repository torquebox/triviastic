
require 'torquebox-stomp'
require 'json'
require 'yaml'

class Control < TorqueBox::Stomp::JmsStomplet
 
  def configure(opts={})
    super
    @host = nil
    @questions = YAML.load( File.read( File.join( ENV['RAILS_ROOT'], 'db/questions.yml' ) ) )
    @control = TorqueBox.fetch( '/topics/questions' )
  end

  def on_subscribe(subscriber)
    @host = subscriber
  end

  def on_message(message, session)
    puts "#{self} message => #{message.inspect}"
    q = next_question()
    @host.send( TorqueBox::Stomp::Message.new( JSON.unparse( q ) ) )
    q.delete( :answer )
    send_to( @control, q, {}, :encoding=>:json )
  end

  def next_question() 
    @questions.shift
  end

end
