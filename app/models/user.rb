require 'digest/sha1'

# TODO: Localization

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of       :email
    
  validates_uniqueness_of     :email,
                              :unless   => Proc.new {|obj| obj.errors.invalid?(:email)}
                              
  validates_length_of         :email,    
                              :within    => 6..100,
                              :unless    => Proc.new {|obj| obj.errors.invalid?(:email)}
                                                               
  validates_format_of         :email,
                              :with     => Authentication.email_regex, 
                              :unless   => Proc.new {|obj| obj.errors.invalid?(:email)}

  validates_email_veracity_of :email, 		 			
 															:domain_check 		=> true,
 															:fail_on_timeout 	=> false,
															:unless 					=> Proc.new {|obj| obj.errors.invalid?(:email)}

  validates_presence_of       :password,
                              :if  => Proc.new {|obj| obj.new_record?}
  
  validates_length_of         :password, 
                              :within    => 6..40,
                              :unless    => Proc.new {|obj| obj.errors.invalid?(:password) or obj.password.blank?}
                              
  validates_confirmation_of   :password,
                              :unless  => Proc.new {|obj| obj.errors.invalid?(:password) or obj.password.blank?}

  attr_accessible :email, :password, :password_confirmation

  def self.authenticate(email, password)
    return nil if email.blank? or password.blank?
    user = User.find(:first, :conditions => {:email => email})
    user and user.authenticated?(password) ? user : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
end