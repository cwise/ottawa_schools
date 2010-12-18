class HomeController < ApplicationController
  include GoogleMapsHelper
  
  def index
    build_lists

    @search=Search.new(params[:search] || session[:search] || {})
    @search.update_address
    session[:search]=@search.attributes

    geocoding_init
    if @search.address.location
      map_zoom Array.[](@search.address.location.y, @search.address.location.x), 10
      
      @schools=School.nearest(@search)
      @boundaries=Boundary.includes([:start_grade, :end_grade]).board(@search.board_id).programme(@search.programme_id).zoned(@search.address.location).all  
      @boundaries=@boundaries.select { |boundary| boundary.contains_point?(@search.address.location) }  # post process boundaries for accuracy (MySQL only does MBR)
          
      # map the target address
      map_it @search.address.geomarker
      
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
    @search=Search.new(params[:search] || session[:search] || {})
    @search.full_address=[@search.full_address, 'Ottawa', 'ON'].join(' ') unless @search.full_address[/Ottawa ON/]    
    session[:search]=@search.attributes
    
    redirect_to root_path
  end
  
  private
  def build_lists
    @boards=[Board.new(:id => 0, :name => 'All')]
    @boards|=Board.order('name').all
    @programmes=[Programme.new(:id => 0, :description => 'All')]
    @programmes|=Programme.order('description').all
  end
end
