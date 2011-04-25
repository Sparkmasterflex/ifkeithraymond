class Contact < ActiveRecord::Base
  after_save :send_email
  validates :name,  :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  private

  def send_email
    Notifier.contact_notification(self).deliver    
  end
end