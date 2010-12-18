class HomeController < ApplicationController
  include GoogleMapsHelper
  
  def index
    @address=session[:address] || Address.new
    geocoding_init
    if @address.location
      map_zoom Array.[](@address.location.y, @address.location.x), 10
      
      @schools=School.nearest(@address.location)
      @boundaries=Boundary.includes([:start_grade, :end_grade]).zoned(@address.location).all  
      @boundaries=@boundaries.select { |boundary| boundary.contains_point?(@address.location) }  # post process boundaries for accuracy (MySQL only does MBR)
          
      # map the target address
      map_it @address.geomarker
      
      # show the applicable boundaries
      @boundaries.each { |boundary| map_it boundary.polygon }
      
      # add markers for each of the schools
      which_marker=1
      @schools.each do |school|
        marker_name="school_icon"
        marker_name="school_zoned_icon" if @boundaries.detect { |boundary| boundary.school_id==school.id } 
        @map.record_init @marker_group.add_marker school.geomarker(marker_name), which_marker
        which_marker+=1
      end
      @map.record_init @marker_group.center_and_zoom_on_markers              
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
