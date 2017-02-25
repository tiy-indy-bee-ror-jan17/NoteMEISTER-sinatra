require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'
require 'json'
# require 'puma'
# require 'rabl'
# require 'active_support/core_ext'
# require 'active_support/inflector'
# require 'builder'
# require 'ostruct'
# configure { set :server, :puma }
# Rabl.configure do |config|
#   config.include_json_root = false
#   config.include_child_root = false
#
# end
# Rabl.register!


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

# def example_note()
#    Note.new(title: params[:title], body: params[:body])
# end


get "/not_found" do
end

get '/api/notes.json' do
  new_notes = Note.all
  new_notes_with_tags = new_notes.collect do |t|
    t.example_note
  end
  new_notes_with_tags.to_json
end

get "/api/notes/tag/:name" do
  new_tag = Tag.find_by(name: params[:name])
  new_tag.to_json() if new_tag
end


# post '/api/notes' do
#   @note = Note.new(title: params[:title], body: params[:body])
#   if note.save
#     params[:tags].split(',').each do |t|
#     tag = Tag.find_or_create_by(name: t)
#     note.tags << tag
#   end
#     note.to_json
#   else
#     @error = OpenStruct.new({code:400, message: @note.errors.full_messages.first})
#   end
# end


# post '/api/notes' do
# @note = Note.new(title: params[:title], body: params[:body])
#   if @note.save
#      @note.json.parse
#   else
#     status 400
#     @error = OpenStruct.new({code:400, message: @note.errors.full_messages.first})
#     @error
#   end
# end
