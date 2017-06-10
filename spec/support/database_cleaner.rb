RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    # JS examples are run with Poltergeist which uses separate db
    # connection. It's impossible to use :transaction strategy in this case
    # because records shouldn't be available outside of the transaction (e.g. in
    # another db connection). For such examples :truncation strategy is more
    # appropriate.
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
