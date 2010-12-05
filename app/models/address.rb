class Address
	extend ActiveModel::Naming
	include ActiveModel::Conversion

	attr_accessor :full_address
	attr_accessor :latitude
	attr_accessor :longitude
	
	def initialize(attributes={})
    unless attributes.empty?
      @full_address=*attributes.values_at(:full_address)
    end
	end
	
	def geocode
    unless (full_address.blank?)
      if (coordinates && coordinates.success?)
        self.latitude=coordinates.lat
        self.longitude=coordinates.lng
      end
    end
  end
	
  def ll
    Array.[]( latitude, longitude )
  end
  
  def coordinates
    unless full_address.blank?
      Geokit::Geocoders::GoogleGeocoder.geocode(full_address)
    end
  end
  	
	def persisted?
	  false
	end
end