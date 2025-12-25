require 'database_cleaner/active_record'

DatabaseCleaner.allow_remote_database_url = true

RSpec.configure do |config|
  # Clear everything before starting the test suite.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # Set the default strategy to transaction (faster).
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # For system tests (which open a browser), use truncation.
  config.before(:each, type: :system) do
    DatabaseCleaner.strategy = :truncation
  end

  # It initializes and clears the database after each test.
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
