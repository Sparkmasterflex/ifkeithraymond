class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string    :feature,      :null => false
      t.text      :description,  :null => false
      t.integer   :project_id,   :null => false
      t.text      :images

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
