class PlayerController < ApplicationController

  def index
    name = params[:team]
    if ( !name.nil? && !name.strip.empty? )
      session[:name] = name.strip
      TorqueBox.fetch( "/topics/roster" ).publish( { :name=>session[:name], :id=>session[:session_id] }, :encoding=>:json )
      redirect_to :play
    end
  end

  def play
    redirect_to '/' if ( session[:name].nil? )
  end

end
