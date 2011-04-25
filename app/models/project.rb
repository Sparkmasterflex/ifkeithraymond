class Project < ActiveRecord::Base
  has_many :features
  has_many :images, :as => :attachable do
    def enabled_images
      find(:all, :conditions => {:enabled => true}, :order => :position)
    end

    def first_image(page_id)
      find(:first, :conditions => {:attachable_id => project_id, :enabled => true })
    end
  end

  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :images

  attr_accessor :tech_values

  before_save :concat_technology

  validates :client, :presence => true

  class Status
    NOT_STARTED   =  0
    PLANNING      = 10
    DESIGN        = 20
    DEVELOPMENT   = 30
    TEST          = 40
    REVAMP        = 50
    COMPLETE      = 60

    LABELS = { NOT_STARTED => 'Not Started', PLANNING => 'Early Planning', DESIGN => 'Design', DEVELOPMENT => 'Development/Programing',
               TEST => 'Testing Started', REVAMP => 'Revamp in Progress', COMPLETE => 'Completed', }

    def self.options_for_select
      LABELS.collect { |arr| arr.reverse }
    end
  end

  class Technology
    HTML        = 'html'
    CSS         = 'css'
    PROTOTYPE   = 'prototype'
    JQUERY      = 'jquery'
    FLASH       = 'flash'
    PHP         = 'php'
    RUBY        = 'ruby'
    RAILS       = 'rails'
    MYSQL       = 'mysql'
    HAML        = 'haml'
    SASS        = 'sass'
    CUSTOM_CMS  = 'custom_cms'
    EE          = 'expression_engine'
    WORDPRESS   = 'wordpress'
    CUSHY       = 'cushy'
    GRAPHICS    = 'graphics'

    LABELS = { HTML => 'HTML5', CSS => 'CSS3', PROTOTYPE => 'Prototype (JS)', JQUERY => 'jQuery (JS)', FLASH => 'Flash/ActionScript 3.0',
               PHP => 'PHP', RUBY => 'Ruby', RAILS => 'Ruby on Rails', MYSQL => 'mySQL', HAML => 'HAML', SASS => 'SASS',
               CUSTOM_CMS => 'Custom CMS', EE => 'Expression Engine', WORDPRESS => 'WordPress', CUSHY => 'Cushy Content Editor', GRAPHICS => 'Custom Graphics' }

    DESC   = { HTML => 'Newest version of HTML.', CSS => 'New styling techniques eliminating the need for alot of images and adding wonderful style to websites.',
               PROTOTYPE => 'Javascript framework allowing for amazing user experience but in half the time as plain JavaScript.',
               JQUERY => 'Javascript framework allowing for amazing user experience but in half the time as plain JavaScript.',
               FLASH => 'Adobe program and language allowing for awesome animations and user interfaces.',
               PHP => 'Server-side technology, used for interacting with databases, shortening long html and allowing for re-use of code.',
               RUBY => 'Server-side technology, used for interacting with databases, shortening long html and allowing for re-use of code.',
               RAILS => 'Ruby framework allowing for quick development and database management.',
               MYSQL => 'Database to manage information.',
               HAML => 'Shorthand and organizer for HTML', SASS => 'Shorthand and organizer for css. Also allows for use of variables and mixins.',
               CUSTOM_CMS => 'My own Content Management System (CMS) built on Ruby on Rails.',
               EE => 'A Content Management System (CMS).', WORDPRESS => 'A Content Management System (CMS).', CUSHY => 'A free Content Editor.',
               GRAPHICS => 'Created in Photoshop or Illustrator, these graphics were specially made for this project.' }

    def self.check_box_values
      LABELS.collect { |arr| arr.reverse }
    end
  end

  def split_technology
    self.technology.split('|')
  end

  def self.available_technologies
    self.find(:all, :select => :technology).map(&:technology).collect {|tech| tech.split('|')}.flatten.uniq
  end

  def self.with_technology(technoloy)
    self.find(:all, :select => [:id, :technology]).reject { |tech| !tech.technology.include?(technoloy)}.map(&:id)
  end

  def has_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id}).any? #self.image_ids.any?
  end

  def has_enabled_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id, :enabled => true}).any? #self.image_ids.any?
  end

  def feature_with(img)
    name = Image.find(img).attachment_file_name
    features = self.features.reject { |f| f.images.nil? || !f.images.split("|").include?(name.to_s)}

    features.empty? ? nil : features.first
  end

  def self.seperate_by_months
    self.find(:all, :select => :end_date, :order => :end_date).map(&:end_date).collect! { |date| date.strftime('%B %Y') }.uniq
  end

  def self.get_range(month)
    date = Date.parse(month)
    days = Time.days_in_month(date.month, date.year)
    return Date.new(date.year, date.month, 1)..Date.new(date.year, date.month, days)
  end
  
  private

  def concat_technology
    self.technology = @tech_values.delete_if { |x| x == "0" } * "|" unless @tech_values.blank?
  end
end
