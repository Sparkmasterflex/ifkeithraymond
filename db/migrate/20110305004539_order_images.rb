class OrderImages < ActiveRecord::Migration
  def self.up
    add_column :images, :position, :integer, :null => false, :default => 0;
  end

  def self.down
    remove_column :images, :position
  end
end
