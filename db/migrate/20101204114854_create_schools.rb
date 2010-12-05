class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.column :board_id, :integer, {:null => false}
      t.column :name, :string, {:length => 256, :null => false, :unique => true}
      t.column :street_address, :string, {:length => 256, :null => false}
      t.column :city, :string, {:length => 256, :null => false}      
      t.column :postal_code, :string, {:length => 7, :null => false}
      t.column :phone, :string, {:length => 20}
      t.column :fax, :string, {:length => 20}      
      t.column :start_grade_id, :integer
      t.column :end_grade_id, :integer      
      t.column :start_time, :time
      t.column :semestered, :boolean, {:default => false}
      t.column :adaptive, :boolean, {:default => false}      
      t.column :end_time, :time
      t.column :principal, :string, {:length => 256}
      t.column :vice_principal, :string, {:length => 256}      
      t.column :url, :string
      t.column :latitude, :float
      t.column :longitude, :float
            
      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
