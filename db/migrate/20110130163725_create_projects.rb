class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string    :title,         :null => false
      t.text      :text,          :null => false
      t.integer   :progress,      :null => false, :default => 0
      t.integer   :status,        :null => false, :default => 0
      t.string    :client
      t.string    :url
      t.datetime  :start_date
      t.datetime  :end_date
      t.integer   :updated_by,     :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
