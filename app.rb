require 'sinatra'
require 'active_record'
require 'sqlite3'
require_relative 'models/note'
require_relative 'models/tagging'
require_relative 'models/tag'
require 'pry'


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get '/api/notes.json' do
  @notes = Note.all
  # @notes.to_json(
  #   except: [:id, :created_at, :updated_at],
  #   include: {tags: {only: :name}}
  # )
  @notes.to_json
end

get '/api/notes/tag/:name' do
  tag = Tag.find_by(name: params[:name])
  tag.to_json(include: :notes)
end

post '/api/notes' do
  # binding.pry
  note = Note.new(
          title: params[:title],
          body: params[:body]
         )
  if note.save
    params[:tags].split(/\s*,\s*/).each do |t|
      note.tags << Tag.find_or_initialize_by(name: t)
    end
    note.to_json
  else
    status 400
    {errors: note.errors.full_messages.collect{|e| {error: e} } }.to_json
  end
end
