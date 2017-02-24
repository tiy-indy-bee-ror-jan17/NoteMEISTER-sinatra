require 'sinatra'
require 'active_record'
require 'sqlite3'
require_relative 'models/tag'
require_relative 'models/tagging'
require_relative 'models/note'


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get '/api/notes.json'
