require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'puma'
require 'pry'
require 'rabl'

require_relative 'models/note'
require_relative 'models/tag'
require_relative 'models/tagging'

configure { set :server, :puma }
Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end
Rabl.register!

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes/tag/:tag_name" do
  # @notes = Tag.find_by(name: params[:tag_name]).notes
  # tags = @notes.map(&:find_tag_name)
  # { name: params[:tag_name], notes: tags }.to_json
  @tag = Tag.find_by(name: params[:tag_name])
  rabl :tag
end

post "/api/notes" do
  @note = Note.new(title: params[:title], body: params[:body])
  params[:tags].split(", ").each do |tag|
    new_tag = Tag.find_or_create_by(name: tag)
    @note.tags << new_tag
  end
  if @note.save
    # @note.find_tag_name.to_json
    rabl :note
  else
    status 400
    { errors: @note.errors.full_messages.map { |error_msg| {error: error_msg} } }.to_json   # note.errors.full_messages needs to be an array of a hashes with key of 'error' and value of note.errors.full_messages
  end
end

get "/api/notes.json", provides: [:json] do
  @notes = Note.all
  # @notes.map(&:find_tag_name).to_json
  rabl :notes
end
