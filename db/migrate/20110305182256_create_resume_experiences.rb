class CreateResumeExperiences < ActiveRecord::Migration
  def self.up
    create_table :resume_experiences do |t|
      t.string    :job_title
      t.string    :company
      t.datetime  :start_year
      t.datetime  :end_year
      t.text      :text

      t.timestamps
    end
  end

  def self.down
    drop_table :resume_experiences
  end
end
