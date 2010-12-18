class AddColourToBoards < ActiveRecord::Migration
  def self.up
    add_column :boards, :colour, :string
  end

  def self.down
    remove_column :boards, :colour
  end
end
