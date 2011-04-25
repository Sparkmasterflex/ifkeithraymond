class Notifier < ActionMailer::Base
  default :from => "no-reply@ifkeithraymond.com"

  def contact_notification(sender)
    @sender = sender
    mail(:to => "raymondke99@gmail.com",
         :from => sender.email,
         :subject => "New Contact from #{sender.name}")
  end
end
