require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'puma'
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'
require 'ostruct'

#require 'pry'

require './models/note.rb'
require './models/tag.rb'
require './models/tagging.rb'

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

def save_error(msg)
  status 400
  {errors: msg.map{ |m| { error: m }}}.to_json
end

get "/api/notes.json" do
  #pull all the notes from database
  @notes = Note.order(:updated_at)
  #format them correctly
  rabl :notes
end

get "/api/notes/tag/:tag" do
  #pull all the notes by tag
  @tag = Tag.find_by(name: params[:tag])
  #format them correctly
  rabl :tag
end

post "/api/notes" do

  note = Note.create(
    title: params[:title],
    body: params[:body]
  )
  if note.save
    params[:tags].split(',').each do |t|
      Tagging.create(
        tag: Tag.find_or_create_by(name: t),
        note: note
      )
    end
  #return values
    @note = note
    rabl :note
  else
    save_error(note.errors.full_messages)
  end
end

post "/api/notes/:note/comment" do
  
  "nothing yet"

end
