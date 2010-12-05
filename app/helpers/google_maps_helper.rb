module GoogleMapsHelper
  def icons_init
    create_icon("school_icon")
    create_icon("home_icon")      
  end

  def icon_init(image_name)
    GIcon.new(
      :image => "/images/markers/" + image_name + ".png",
      :icon_size => GSize.new(32, 32),
      :icon_anchor => GPoint.new(0,40),
      :info_window_anchor => GPoint.new(9,2))
  end

  def geocoding_init
    @map=GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)
    @marker_group=GMarkerGroup.new(true, {})
    @map.overlay_global_init(@marker_group, "marker_group")
    
    icons_init
  end

  def map_it geomarker
    @map.overlay_init geomarker
  end

  def map_zoom ll, zoom
    @map.center_zoom_init ll, zoom
  end
  
  def create_icon(marker_name)
    @map.icon_global_init(icon_init(marker_name), marker_name)
    Variable.new(marker_name)
  end

  def marker_path(marker_name)
    "/images/markers/" + marker_name + ".png"
  end
end
