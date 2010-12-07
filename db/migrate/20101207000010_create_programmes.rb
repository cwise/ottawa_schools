class CreateProgrammes < ActiveRecord::Migration
  def self.up
    create_table :programmes do |t|
      t.column :code, :string, {:length => 2, :null => false, :unique => true}
      t.column :description, :string, {:length => 256, :null => false, :unique => true}   

      t.timestamps
    end
  end

  def self.down
    drop_table :programmes
  end
end
