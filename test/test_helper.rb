require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/pride'
require 'active_record'
require 'faker'
require 'factory_girl'
require 'rack/test'
require 'shoulda/matchers'
require 'database_cleaner'

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions

DatabaseCleaner.strategy = :truncation

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
  end
end

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/test.sqlite3'
)


class JacquesTest < Minitest::Test

  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def app
    Sinatra::Application
  end

end
