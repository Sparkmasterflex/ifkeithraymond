class CreateResumeEducations < ActiveRecord::Migration
  def self.up
    create_table :resume_educations do |t|
      t.string    :school
      t.datetime  :graduation_date
      t.string    :degree
      t.text      :text

      t.timestamps
    end
  end

  def self.down
    drop_table :resume_educations
  end
end
