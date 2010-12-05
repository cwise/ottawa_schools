class HomeController < ApplicationController
  include GoogleMapsHelper
  
  def index
    @address=session[:address] || Address.new
    geocoding_init
    if @address.location
      map_zoom Array.[](@address.location.y, @address.location.x), 10
      
      @schools=School.nearest(@address.location.y, @address.location.x)       
      map_it @address.geomarker
      
      which_marker=1
      @schools.each do |school|
        map_it school.geomarker
      end        
    else
      map_zoom Array.[](45.4108, -75.6986), 10 
    end
  end
  
  def search
    @address=Address.new(params[:address])
    @address.full_address=[@address.full_address, 'Ottawa', 'ON'].join(' ') unless @address.full_address[/Ottawa ON/]
    @address.geocode
    session[:address]=@address
    
    redirect_to root_path
  end
end
