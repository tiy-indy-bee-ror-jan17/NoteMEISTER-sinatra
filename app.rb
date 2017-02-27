require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'
require_relative 'models/note'
require_relative 'models/tagging'
require_relative 'models/tag'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get '/api/notes.json' do
  notes = Note.all
  notes.to_json
end

get "/api/notes/tag/:name" do
  tag = Tag.find_by(name: params['name'])
  if tag != nil
    json = tag.to_json
  else
    status 400
    error = notes.errors.full_messages.collect do |error_message|
      {:error => error_message}
    end
    errors = {:errors => error}
    json = JSON.generate(errors)
  end
  json
end

post '/api/notes' do
  notes = Note.new(title: params['title'], body: params['body'])
  if notes.save
    status 200
    if params['tags'] != nil
      tags_array = params['tags'].split(%r{,\s*})
      tags_array.each do |tag|
        if Tag.find_by(name: tag) == nil #name is unique
          tag_obj = Tag.create(name: tag)
        else #return id for tag on name
          tag_obj = Tag.find_by(name: tag)
        end
        Tagging.create(tag_id: tag_obj.id, note_id: notes.id)
      end
    end
    tags = notes.tags.collect do |note_tag|
      {:name => note_tag.name}
    end
    notes_json = {:title => notes.title, :body => notes.body, :tags => tags}
    json = JSON.generate(notes_json)
  else
    status 400
    error = notes.errors.full_messages.collect do |error_message|
      {:error => error_message}
    end
    errors = {:errors => error}
    json = JSON.generate(errors)
  end
  json
end

after do
  ActiveRecord::Base.clear_active_connections!
end
