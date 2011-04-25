class Blog < ActiveRecord::Base
  has_many :images, :as => :attachable do
    def enabled_images
      find(:all, :conditions => {:enabled => true }, :order => :position)
    end

    def first_image(page_id)
      find(:first, :conditions => {:enabled => true }, :order => :position)
    end
  end

  accepts_nested_attributes_for :images

  class Categories
    UNCATEGORIZED  =  0
    TRAVEL         = 10
    PROJECT        = 20
    TECHNOLOGY     = 30
    RANT           = 40
    JANE           = 50

    LABELS = {UNCATEGORIZED => 'Uncategorized', TRAVEL => 'Travel/Vacation', PROJECT => 'Projects', TECHNOLOGY => 'Technology', RANT => 'My Rants', JANE => 'Jane\'s Blog'}

    def self.options_for_select
      LABELS.collect { |arr| arr.reverse }.unshift(['Please Select', nil])
    end
  end

  def self.seperate_by_months
    self.find(:all, :select => :created_at, :order => :created_at).map(&:created_at).collect! { |date| date.strftime('%B %Y') }.uniq!
  end

  def self.get_range(month)
    date = Date.parse(month)
    days = Time.days_in_month(date.month, date.year)
    return Date.new(date.year, date.month, 1)..Date.new(date.year, date.month, days)
  end

  def self.available_categories
    self.find(:all, :select => :category).map(&:category).uniq
  end

  def self.latest
    self.find(:all, :limit => 1, :order => 'created_at DESC').last
  end

  def has_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id}).any? #self.image_ids.any?
  end

  def has_enabled_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id, :enabled => true}).any? #self.image_ids.any?
  end

  def author_name
    author = User.find(self.author)
    
    "#{author.first_name} #{author.last_name}"
  end

  
end
