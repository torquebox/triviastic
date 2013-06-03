
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
    payload = JSON.parse( message.content_as_string )
    puts "#{self} message => #{payload}"
    if ( payload['type'] == 'next-question' )
      q = next_question()
      if ( @questions.empty? ) 
        q['last'] = true
      end
      @host.send( TorqueBox::Stomp::Message.new( JSON.unparse( q ) ) )
      q.delete( :answer )
      send_to( @control, q, {}, :encoding=>:json )
    elsif  ( payload['type'] == 'lock-question' )
      puts "LOCKING" 
      send_to( @control, { 'type'=>'lock-question', 'answer'=>payload['answer'] }, {}, :encoding=>:json )
    end
  end

  def next_question() 
    @questions.shift
  end

end
