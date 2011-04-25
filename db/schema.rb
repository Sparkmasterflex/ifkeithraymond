# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110310235853) do

  create_table "blogs", :force => true do |t|
    t.string   "title",                     :null => false
    t.text     "text",                      :null => false
    t.integer  "category",   :default => 0, :null => false
    t.integer  "author",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.string   "feature",     :null => false
    t.text     "description", :null => false
    t.integer  "project_id",  :null => false
    t.text     "images"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "caption"
    t.boolean  "enabled",                 :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                :default => 0,     :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "text",                          :null => false
    t.integer  "progress",   :default => 0,     :null => false
    t.integer  "status",     :default => 0,     :null => false
    t.string   "client"
    t.string   "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "updated_by",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "technology"
    t.boolean  "front_page", :default => false
    t.integer  "order",      :default => 0
  end

  create_table "resume_educations", :force => true do |t|
    t.string   "school"
    t.datetime "graduation_date"
    t.string   "degree"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_experiences", :force => true do |t|
    t.string   "job_title"
    t.string   "company"
    t.datetime "start_year"
    t.datetime "end_year"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "email1"
    t.string   "email2"
    t.string   "affiliations1"
    t.string   "affiliations2"
    t.string   "affiliations3"
    t.string   "affiliations4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subpages", :force => true do |t|
    t.integer  "webpage_id"
    t.string   "page_alias"
    t.integer  "template",   :default => 20, :null => false
    t.string   "page_title"
    t.text     "text"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                         :null => false
    t.string   "last_name",                          :null => false
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  create_table "webpages", :force => true do |t|
    t.string   "page_alias"
    t.integer  "template",   :default => 20, :null => false
    t.string   "page_title"
    t.text     "text"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
