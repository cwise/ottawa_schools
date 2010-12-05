class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.column :index, :integer, {:null => false, :unique => true} 
      t.column :abbrev, :string, {:length => 3, :null => false, :unique => true}
      t.column :description, :string, {:length => 256, :null => false, :unique => true}   
      
      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
