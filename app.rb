require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes/" do
end

get "/api/notes.json" do
  notes = Note.all
  output = notes.collect do |n|
    {
      "title" => n.title,
      "body" => n.body,
      "tags" => n.tags.collect { |t| {"name" => t.name} }
    }
  end
  output.to_json(except: :id)
end

get "/api/notes/tag/:name" do
  #Find a tag by its name
  tag_name = Tag.find_by(name: params[:name])
  notes = tag_name.notes
  output = {
            "name" => tag_name.name,
            "notes" => notes.collect do |n|
              {
                "title" => n.title,
                "body" => n.body,
                "tags" => n.tags.collect { |t| {"name" => t.name} }
              }
            end
            }
  output.to_json(except: :id)
end

post "/api/notes" do
  note = Note.new(
    {
      title: params[:title],
      body: params[:body],
    }
    )
    if note.save
      params['tags'].split(/,\s?/).each do |t|
        tag = Tag.find_or_create_by(name: t)
        note.tags << tag
      end
      note.to_json
    else
      status 400
      {errors: note.errors.full_messages.collect{ |e| {error: e}}}.to_json
    end
end
