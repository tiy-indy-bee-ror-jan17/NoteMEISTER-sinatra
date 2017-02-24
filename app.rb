require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'puma'
require 'pry'

require_relative 'models/note'
require_relative 'models/tag'
require_relative 'models/tagging'

configure { set :server, :puma }

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes/tag/:tag_name" do
  notes = Tag.find_by(name: params[:tag_name]).notes
  tags = notes.map { |note| {title: note.title, body: note.body, tags: note.tags.map { |tag| {name: tag.name} } } }
  { name: params[:tag_name], notes: tags }.to_json
end

post "/api/notes" do
  note = Note.new(title: params[:title], body: params[:body])
  params[:tags].split(", ").each do |tag|
    new_tag = Tag.find_or_create_by(name: tag)
    note.tags << new_tag
  end
  if note.save
    { title: params[:title], body: params[:body], tags: note.tags.map { |tag| {name: tag.name} } }.to_json
  else
    status 400
    { errors: note.errors.full_messages.map { |error| {error: error} } }.to_json   # note.errors.full_messages needs to be an array of a hashes with key of 'error' and value of note.errors.full_messages
  end
end

get "/api/notes.json" do
  notes = Note.all
  notes.map { |note| {title: note.title, body: note.body, tags: note.tags.map { |tag| {name: tag.name} }} }.to_json
end
