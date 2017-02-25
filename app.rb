require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'ostruct'
# require 'rabl'
# Rabl.register!

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
  )

get '/api/notes' do
  status 200
  notes = Note.all
  notes
end

get '/api/notes.json' do
  notes = Note.all
  notes.to_json
end

get "/api/notes/tag/:name" do
  t = Tag.find_by(name: params[:name])
  t.to_json(
    :include => ["notes.tags"],
    :exclude => ["tags"]
    )
  # {name: :name, notes: [a,b,c]
end

get "/not_found" do
  status 404
end

post '/api/notes' do
  # get all the notes, & display as JSON
  # throw and erro if they hit the wrong path
  note = Note.new(body: params[:body], title: params[:title])
  if note.save
    params[:tags].split(',').each do |t|
      tag = Tag.find_or_create_by(name: t)
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
