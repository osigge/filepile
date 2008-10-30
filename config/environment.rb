RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.frameworks -= [:active_resource]

  config.time_zone = 'Berlin'

  config.action_controller.session = {
    :session_key => 'filepile_session',
    :secret      => 'e35434b3ede9187cfae03b1330d6377d32dd166ef867a2c0702b467e04b60512ec687398b79d9d26b538e81bb4a57c1fe27bfae1ed0403deb599b76c3e8b98c4'
  }

end  

ExceptionNotifier.exception_recipients = ['yves.vogl@dock42.com', 'osigge@mac.com']  