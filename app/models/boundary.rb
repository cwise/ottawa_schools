class Boundary < ActiveRecord::Base
  belongs_to :school
  belongs_to :programme
  belongs_to :start_grade, :class_name => 'Grade'
  belongs_to :end_grade, :class_name => 'Grade'
  validates :name, :presence => true
  scope :zoned, lambda {|location| where(["MBRContains(bounds, ?)", location])}
  scope :board, lambda {|board_id| where(["school_id IN (SELECT id FROM schools WHERE board_id = ?)", board_id]) unless board_id.to_i.zero?}
  scope :programme, lambda {|programme_id| where(["programme_id = ?", programme_id]) unless programme_id.to_i.zero?}
  
  def start_grade_code=(abbrev)
    self.start_grade_id=Grade.where(:abbrev => abbrev).first.id
  end
  
  def end_grade_code=(abbrev)
    self.end_grade_id=Grade.where(:abbrev => abbrev).first.id
  end
  
  def programme_code=(code)
    self.programme_id=Programme.where(:code => code).first.id
  end
  
  def interpret_name
    # name is in the format NAMEKEY_STARTGRADE_ENDGRADE_PROGRAMMECODE
    parts=name.upcase.gsub('.KML', '').split('_')
    self.school_id=School.where(:name_key => parts[0]).first.id
    self.start_grade_code=parts[1]
    self.end_grade_code=parts[2]
    self.programme_code=parts[3]
  end
  
  def polygon
    p=GPolygon.from_georuby(bounds)
    p.opacity=programme.opacity.to_f/100.0
    p.color=school.board.colour
    p
  end
  
  def self.read_from_file(path)
    xml=File.read(path)
    doc=Hpricot::XML(xml)
    name=(doc/"name").first.to_plain_text
    polygon=doc/"Placemark/Polygon"
    
    b=Boundary.new(:name => name)
    b.interpret_name
    b.bounds=GeoRuby::SimpleFeatures::Geometry.from_kml(polygon.to_s)
    b
  end

  def self.load_overlays
    Boundary.delete_all
    files=Dir.glob("data/overlays/*.kml")
    files.each do |file_name|
      puts file_name
      b=Boundary.read_from_file(file_name)
      b.save
    end
  end

  def contains_point?(point)
    contains_point = false
    bounds.each do |linear_ring|
      i = -1
      j = linear_ring.size - 1
      while (i += 1) < linear_ring.size
        a_point_on_polygon = linear_ring[i]
        trailing_point_on_polygon = linear_ring[j]
        if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
          if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
            contains_point = !contains_point
          #  return true
          end
        end
        j = i
      end
    end
    return contains_point
  end

  private
  def point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
    (a_point_on_polygon.y <= point.y && point.y < trailing_point_on_polygon.y) || 
    (trailing_point_on_polygon.y <= point.y && point.y < a_point_on_polygon.y)
  end

  def ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
    (point.x < (trailing_point_on_polygon.x - a_point_on_polygon.x) * (point.y - a_point_on_polygon.y) / 
               (trailing_point_on_polygon.y - a_point_on_polygon.y) + a_point_on_polygon.x)
  end  
end
