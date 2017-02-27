require 'bundler/setup'
require 'pry'
require 'pry-nav'
require 'minitest/autorun'
require 'minitest/pride'
require 'active_record'
require 'faker'
require 'factory_girl'
require 'rack/test'
require 'database_cleaner'
require_relative '../models/tag'
require_relative '../models/tagging'
require_relative '../models/note'
require_relative '../app'

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions

DatabaseCleaner.strategy = :truncation

require_relative './test_connection'

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
