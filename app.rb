require 'sinatra'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes.json" do
  Note.all.to_json
end

get "/api/notes/tag/:key" do
  tag = Tag.find_by(name: params[:key])
    tag.to_json if tag
end

post "/api/notes" do
   note = Note.new(
     title: params[:title],
     body: params[:body]
     )

  if note.save
    params[:tags].split(',').each do |name|
      tag = Tag.find_or_create_by(name: name)
      note.tags << tag
    end
    note.to_json
    else
      status 400
      {errors: note.errors.full_messages.collect{ |e|{error: e}}}.to_json
  end
end
