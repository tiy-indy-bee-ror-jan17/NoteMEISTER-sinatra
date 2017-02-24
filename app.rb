require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'puma'
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'
require 'ostruct'

require './models/note.rb'
require './models/tag.rb'
require './models/tagging.rb'

configure { set :server, :puma }

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)


get "/api/notes" do
  #pull all the notes from database
  #format them correctly
  "get all the notes"
end

get "/api/notes/tag/:tag" do
  #pull all the notes by tag
  #format them correctly
  "get all the notes for #{params[:tag]}."
end

post "/api/notes" do
  #parse the input

  #make a new note and tags

  note = Note.create(
    title: params[:title],
    body: params[:body]
  )
  params[:tags].split(',').each do |t|
    Tagging.create(
      tag: Tag.find_or_create_by(name: t),
      note: note
    )
  end
  #return values

end
