module ApplicationHelper
  def endpoint() 
    TorqueBox::fetch( "stomp-endpoint" )
  end
end
