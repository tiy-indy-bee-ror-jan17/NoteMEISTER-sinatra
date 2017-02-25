require 'puma'
require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'ostruct'
require 'rabl'
configure {set :server, :puma}
Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end
Rabl.register!

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
  # @noter = OpenStruct.new(notes)
  # rabl @noter
  notes.to_json
end

get "/api/notes/tag/:name" do
  t = Tag.find_by(name: params[:name])
  t.to_json if t
  # {name: :name, notes: [note1, note2, note3]
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
