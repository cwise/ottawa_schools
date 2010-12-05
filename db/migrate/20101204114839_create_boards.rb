class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.column :code, :string, {:length => 1, :null => false, :unique => true}
      t.column :name, :string, {:length => 256, :null => false, :unique => true}    
        
      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
