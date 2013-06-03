class HostController < ApplicationController

  def index
    if ( session[:host] ) 
      redirect_to :host
    end

    if ( params[:password] == 'torquebox4242' ) 
      session[:host] = true
      redirect_to :host
    end
  end

  def host
    redirect_to :host_login if ( ! session[:host] ) 
  end

end
