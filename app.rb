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
  tagg.to_json if tagg
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
    {errors: note.errors.full_messages.collect{ |e|
      {error: e}
    }}.to_json
  end
end
