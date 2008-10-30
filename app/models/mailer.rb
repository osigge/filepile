class Mailer < ActionMailer::Base
  include ActionController::UrlWriter
     
  # Signup
  def signup_notification(user)
    setup_email
    recipients  user.email
    subject     'Ihr Benutzerkonto wurde eingerichtet'
    body	      :user => user
  end

protected

  def setup_email(data = nil)
    from 	  'FilePile <noreply@example.com>'
    headers 'Reply-to' => 'FilePile Support <support@example.com>'
    sent_on Time.now	
  end  
  
end
