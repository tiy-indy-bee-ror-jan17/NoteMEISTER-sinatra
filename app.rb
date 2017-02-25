require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'json'
require './models/note'
require './models/tag'
require './models/tagging'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get '/api/notes.json' do
  Note.all.to_json
end

post '/api/notes' do
  hash_tags = params[:tags].split(", ").map{ |tag| Tag.find_or_create_by(name: tag) }
  note = Note.new(title: params[:title], body: params[:body])
  if note.save
    note.tags = hash_tags
    note.to_json
  else
    status 400
    { errors: note.errors.full_messages.map{ |message| { error: message } } }.to_json
  end
end

get "/api/notes/tag/:tag_name" do
  tag = Tag.find_by(name: params[:tag_name])
  { name: tag.name, notes: tag.notes }.to_json
end
