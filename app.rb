require 'sinatra'
require 'active_record'
require 'sqlite3'

configure { set :server, :puma }

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)
