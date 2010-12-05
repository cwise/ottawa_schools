class HomeController < ApplicationController
  def index
    @address=session[:address] || Address.new
    @schools=School.nearest(@address.latitude, @address.longitude) if @address
  end
  
  def search
    @address=Address.new(params[:address])
    @address.full_address=[@address.full_address, 'Ottawa', 'ON'].join(' ') unless @address.full_address[/Ottawa ON/]
    @address.geocode
    session[:address]=@address
    
    redirect_to root_path
  end
end
