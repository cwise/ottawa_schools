class School < ActiveRecord::Base
  belongs_to :board
  belongs_to :start_grade
  belongs_to :end_grade
  validates :name, :presence => true
  validates :street_address, :presence => true
  validates :city, :presence => true
  validates :postal_code, :presence => true  
  before_save :geocode  
    
  def self.nearest(lat, lng)
    find_by_sql(["SELECT schools.*, distance(?, ?, latitude, longitude) as distance FROM schools HAVING distance < 5 ORDER BY distance LIMIT 10", lat, lng])
  end
  
  def distance
    attributes['distance']
  end  
  
  def start_grade_code=(code)
    start_grade=Grade.where(:code => code).first
  end
  
  def end_grade_code=()
    end_grade=Grade.where(:code => code).first
  end  
  
  def is_geocoded?
    return !(latitude.nil? || longitude.nil?)
  end

  def geocode
    unless ((self.changed & [:street_address.to_s, :city.to_s, :postal_code.to_s]).empty?)
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
  
  def full_address
    formatted_address(" ").chomp
  end

  def formatted_address(delim)
    city_region=[city, 'ON'].join(" ")
    [street_address, city_region, postal_code].join(delim)
  end  
    
  def self.raw_line_to_attributes(line, line_number)
    attrs={}
    case line_number
    when 0
      pattern=/(.+(School|Institute|Centre|Collegiate))(.+)(\d{3}-\d{4})$/
      fields=[:name, nil, :principal, :phone]
    when 1
      pattern=/(.+(St|Rd|Blvd|Dr|Cr|Ave|way))(.+)(\d{3}-\d{4})$/
      fields=[:street_address, nil, :vice_principal, :fax]
    when 2
      pattern=/(.+)([A-Z]\d[A-Z] \d[A-Z]\d)(.+)((JK|K|\d+)-(\d+))/
      fields=[:city, :postal_code, nil, nil, :start_grade_code, :end_grade_code]
    when 3
      pattern=/(.+)((\d+:\d+)-(\d+:\d+))/
      fields=[nil, nil, :start_time, :end_time]                  
    end
    
    fields.each_with_index do |field, index|
      if field
        value=line[pattern, index+1]
        value.lstrip! unless value.blank?
        value.rstrip! unless value.blank?
        attrs[field]=value if field
      end
    end
    attrs
  end
  
  def self.attributes_from_lines(lines)
    attrs={}
    lines.each_with_index {|line, index| attrs.merge!(self.raw_line_to_attributes(line, index))}
    attrs
  end
  
  def self.read_from_raw
    lines=nil
    bad_count=0
    good_count=0
    f=File.new("#{Rails.root}/data/ocdsb-raw.txt", "r")
       while(line=f.readline)
         line.chomp
         unless lines 
           lines=[]
         end
         
         unless line.blank?
           lines.push(line)
         else
           school=School.new(attrs=School.attributes_from_lines(lines))
           school.board=Board.where(:code => 'O').first
           school.save if school.valid?
           sleep 1 # need to sleep or Google will get mad at Geocoding
           unless school.valid?
             puts "Bad School"
             puts "#{school.name} - (#{school.errors})" 
             puts "#{school.attributes}"
             puts "Lines = #{lines}"
             bad_count+=1
           else
             good_count+=1
           end
           lines=nil
         end
       end
    rescue EOFError
        f.close    
        puts "Added: #{good_count} Rejected: #{bad_count}"
  end
end
