require 'sinatra'
require 'active_record'
require 'sqlite3'
require_relative 'models/tag'
require_relative 'models/tagging'
require_relative 'models/note'


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes.json" do
  nte = Note.all
  nte.to_json
end

get "/api/notes/tag/:name" do
  tg = Tag.find_by(name: params[:name])
  if tg
    tg.to_json
  end
end


post "/api/notes" do
  post = Note.new(
    title: params[:title],
    body: params[:body],
  )
  if post.save
    params[:tags].split(",").collect(&:strip).each do |name|
      post.tags << Tag.find_or_initialize_by(name: name)
    end
  post.to_json
  else
    status 400
    {errors: post.errors.full_messages.collect{|e| {error: e}}}.to_json
  end
end
