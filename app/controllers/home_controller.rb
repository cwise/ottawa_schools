class HomeController < ApplicationController
  def index
    @address=session[:address] || Address.new
  end
  
  def search
    @address=Address.new(params[:address])
    @address.full_address=[@address.full_address, 'Ottawa', 'ON'].join(' ') unless @address.full_address[/Ottawa ON/]
    @address.geocode
    session[:address]=@address
    
    @schools=School.nearest(@address.latitude, @address.longitude)
    
    redirect_to root_path
  end
end
