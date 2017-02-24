require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes.json" do
  notes = Note.all
  notes.to_json
end

get "/api/notes/tag/:tags" do
  # pulls every note that includes the [:tag]
  tagg = Tag.find_by(name: params[:tags])
  if tagg
    tagg.to_json
  end
end


post "/api/notes" do
  @note = Note.new(
  title: params[:title],
  body: params[:body]
  )
  if @note.save
    #put note
    #split on the comma, strip spaces out &, loop over it and pump it into notes[tag] column
    #find and create a tag for that
    notes.tag << Tag.find_or_create_by(name: params[:name])
    #notes.tag << tag object
  else
    status 400
    # render hash to json
    errors = {error: "Title can't be blank"}
    errors
  end
end
