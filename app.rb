#!/usr/bin/env ruby
require 'sinatra'
require 'puma'
require 'rabl'
require 'active_record'
require 'sqlite3'
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
      tag = Tag.find_or_create_by(name: name)
      note.tags << tag
    end
    jsonize.(
      note
    )
  else
    status 400
    jsonize.(
      Hash(
        errors: note.errors.full_messages.collect do |message|
          {error: message}
        end
      )
    )
  end
end
