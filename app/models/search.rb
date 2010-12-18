class Search  
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
	attr_accessor :full_address
	attr_accessor :board_id
	attr_accessor :programme_id
	attr_accessor :address
	
	def initialize(attributes={})
    unless attributes.empty?
      @full_address, @board_id, @programme_id=*attributes.values_at(:full_address, :board_id, :programme_id)
    else
  	  self.full_address=''
  	  self.board_id=0
  	  self.programme_id=0
	  end
	  update_address
	end
	
	def attributes
    attributes={}
    attributes[:full_address]=full_address
    attributes[:board_id]=board_id
    attributes[:programme_id]=programme_id    
    attributes
  end	
  
  def persisted?
    false
  end
  
  def update_address
    self.address=Address.new
    self.address.full_address=self.full_address  
    self.address.geocode
    self.full_address=self.address.full_address
  end
end