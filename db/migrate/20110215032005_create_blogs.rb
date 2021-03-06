class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string  :title,    :null => false
      t.text    :text,     :null => false
      t.integer :category, :null => false, :default => 0
      t.integer :author,   :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
