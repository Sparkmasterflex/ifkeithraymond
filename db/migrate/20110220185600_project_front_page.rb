class ProjectFrontPage < ActiveRecord::Migration
  def self.up
    add_column :projects, :front_page, :boolean, :default => false
    add_column :projects, :order, :integer, :default => 0
  end

  def self.down
    remove_column :projects, :front_page
    remove_column :projects, :order
  end
end
