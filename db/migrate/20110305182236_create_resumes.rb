class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :phone1
      t.string :phone2
      t.string :email1
      t.string :email2
      t.string :affiliations1
      t.string :affiliations2
      t.string :affiliations3
      t.string :affiliations4

      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
