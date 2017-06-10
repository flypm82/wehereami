require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whereiam
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # SMTP settings
    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #     authentication: :plain,
    #     address: Rails.application.secrets.smtp_host,
    #     port: Rails.application.secrets.smtp_port,
    #     domain: Rails.application.secrets.smtp_domain,
    #     user_name: Rails.application.secrets.smtp_username,
    #     password: Rails.application.secrets.smtp_password,
    #     ssl: Rails.application.secrets.smtp_ssl
    # }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.smtp_settings = {
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :domain => 'bravo-whereiam.herokuapp.com/',
        :address => 'smtp.sendgrid.net',
        :port => 587,
        :authentication => :plain,
        :enable_starttls_auto => true
    }
  end
end
