class Webpage < ActiveRecord::Base
  has_many :subpages do
    def limit(num)
      find(:all, :order => :created_at, :limit => num)
    end
  end
  has_many :images, :as => :attachable do
    def enabled
      find(:all, :conditions => {:enabled => true }, :order => :position)
    end

    def first_image(page_id)
      find(:first, :conditions => {:attachable_id => page_id, :enabled => true })
    end
  end

  accepts_nested_attributes_for :subpages
  accepts_nested_attributes_for :images

  before_save :create_page_alias

  def self.last_page_updated(user)
    self.find(:first, :conditions => {:updated_by => user.id}, :order => :updated_at) || "No pages updated by #{user.login}"
  end

  def self.subpages_for(webpage)
    self.find(:first, :conditions => {:page_alias => webpage}).subpages
  end

  def has_subpages?
    self.subpage_ids.any?
  end

  def has_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id}).any? #self.image_ids.any?
  end

  def has_enabled_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id, :enabled => true}).any? #self.image_ids.any?
  end

  private

  def create_page_alias    
    self.send("page_alias=", self.page_title.gsub(/[ -,]/, "_").downcase)
  end
end
