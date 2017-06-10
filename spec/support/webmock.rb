require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    WebMock.disable_net_connect!
  end

  config.before(:each, type: :feature) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
