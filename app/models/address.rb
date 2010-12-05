class Address
	extend ActiveModel::Naming
	include ActiveModel::Conversion

	attr_accessor :full_address
	attr_accessor :location
	
	def initialize(attributes={})
    unless attributes.empty?
      @full_address=*attributes.values_at(:full_address)
    end
	end
	
	def geocode
    unless (full_address.blank?)
      if (coordinates && coordinates.success?)
        self.location=Point.from_x_y(coordinates.lng, coordinates.lat)
      end
    end
  end
	
  def ll
    Array.[](location.y, location.x)
  end
  
  def coordinates
    unless full_address.blank?
      Geokit::Geocoders::GoogleGeocoder.geocode(full_address)
    end
  end
  
  def geomarker
    info="<h4>#{full_address}</h4>"
    GMarker.new(ll, :icon => Variable.new("home_icon"), :title=> full_address, :info_window => info)  
  end  
  	
	def persisted?
	  false
	end
end