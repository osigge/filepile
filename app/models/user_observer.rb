class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Mailer.deliver_signup_notification user
  end
end
