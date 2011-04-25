#ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => false, # needs to be true on server
#  :address => 'smtp.gmail.com',
#  :port => 587,
#  :domain => 'ifkeithraymond.com',
#  :authentication => :plain,
#  :user_name => 'raymondke99@gmail.com',
#  :password => 'Mate255Coffee'
}

