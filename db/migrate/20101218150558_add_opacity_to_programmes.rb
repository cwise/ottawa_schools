class AddOpacityToProgrammes < ActiveRecord::Migration
  def self.up
    add_column :programmes, :opacity, :integer
  end

  def self.down
    remove_column :programmes, :opacity
  end
end
