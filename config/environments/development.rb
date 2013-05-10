Mgmt::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.eager_load = false

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Github
  config.github = OpenStruct.new
  config.github.subscribe_to_events = false

  config.action_mailer.delivery_method = :sendmail
  # Defaults to:
  # config.action_mailer.sendmail_settings = {
  #   location: '/usr/sbin/sendmail',
  #   arguments: '-i -t'
  # }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: 'mailer@wolox.com.ar'}
  # Mailer configuration
  config.action_mailer.default_url_options = { :host => "localhost:3001" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.mandrillapp.com',
    :port                 => 587,
    :domain               => 'wolox.com.ar',
    :user_name            => 'mailer@wolox.com.ar',
    :password             => '491Eb0tWRBFIjfWkPwgNNA',
    :authentication       => 'login',
    :openssl_verify_mode => 'none',
    :enable_starttls_auto => false,
  }

end
