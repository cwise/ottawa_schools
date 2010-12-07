unless Board.exists?
  Board.create(:code => 'O', :name => 'Ottawa-Carleton District School Board')
  Board.create(:code => 'C', :name => 'Ottawa Catholic School Board')
end

unless Grade.exists?
  Grade.create(:index => -1, :abbrev => 'JK', :description => 'Kindergarten - Junior')
  Grade.create(:index => 0, :abbrev => 'SK', :description => 'Kindergarten - Senior')
  Grade.create(:index => 1, :abbrev => '1', :description => 'Grade 1')
  Grade.create(:index => 2, :abbrev => '2', :description => 'Grade 2')
  Grade.create(:index => 3, :abbrev => '3', :description => 'Grade 3')
  Grade.create(:index => 4, :abbrev => '4', :description => 'Grade 4')
  Grade.create(:index => 5, :abbrev => '5', :description => 'Grade 5')
  Grade.create(:index => 6, :abbrev => '6', :description => 'Grade 6')
  Grade.create(:index => 7, :abbrev => '7', :description => 'Grade 7')
  Grade.create(:index => 8, :abbrev => '8', :description => 'Grade 8')
  Grade.create(:index => 9, :abbrev => '9', :description => 'Grade 9')
  Grade.create(:index => 10, :abbrev => '10', :description => 'Grade 10')
  Grade.create(:index => 11, :abbrev => '11', :description => 'Grade 11')
  Grade.create(:index => 12, :abbrev => '12', :description => 'Grade 12')  
end

unless Programme.exists?
  Programme.create(:code => 'E', :description => 'English')
  Programme.create(:code => 'FE', :description => 'Early French Immersion')
  Programme.create(:code => 'FL', :description => 'Late French Immersion')  
end