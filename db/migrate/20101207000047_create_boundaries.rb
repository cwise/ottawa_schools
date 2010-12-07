class CreateBoundaries < ActiveRecord::Migration
  def self.up
    create_table :boundaries, :options=>"ENGINE=MyISAM", :force => true do |t|
      t.column :school_id, :integer, {:null => false}
      t.column :name, :string, {:length => 256, :null => false, :unique => true}
      t.column :programme_id, :integer, {:null => false}
      t.column :start_grade_id, :integer, {:null => false}
      t.column :end_grade_id, :integer, {:null => false}
      t.column :bounds, :polygon, :null => false

      t.timestamps
    end
    
    add_index :boundaries, :bounds, :spatial => true    
  end

  def self.down
    drop_table :boundaries
  end
end
