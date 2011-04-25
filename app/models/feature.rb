class Feature < ActiveRecord::Base
  belongs_to :project

  def attach_a(img)
    unless self.images.blank?
      self.images += "|#{img}"
    else
      self.images = img
    end
  end

  def seperated_images
    @seperated_images ||= self.images.nil? ? nil : Image.find(:all, :conditions => {:attachment_file_name => self.images.split("|")})
  end
end
