#!/usr/bin/env ruby
require 'sinatra'
require 'puma'
require 'rabl'
require 'active_record'
require 'sqlite3'
# require 'ostruct'
require './models/note'
require './models/tagging'
require './models/tag'
# require './dev_connection.rb'

configure { set :server, :puma }

Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end
Rabl.register!

jsonize = -> (_){ _.to_json }

get '/api/notes.json' do
  jsonize.(
    Note.list
  )
end

get '/api/notes/tag/:name' do
  jsonize.(
    Tag.find_by(name: params[:name])
  )
end

post '/api/notes' do
  note = Note.new(
           title: params[:title],
           body: params[:body]
         )
  if note.save
    params[:tags].split(/\s*,\s*/).each do |name|
      note.tags << Tag.find_or_create_by!(name: name)
    end
    jsonize.(note)
  else
    status 400
    error_list = note.errors.full_messages
    errors = error_list.map { |_| Hash(error: _) }
    @error = Struct.new(:code, :errors)
                   .new(400, errors)
    rabl :error
  end
end
