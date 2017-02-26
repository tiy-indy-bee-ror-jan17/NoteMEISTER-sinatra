require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'
require 'puma'
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'

configure { set :server, :puma }
Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false

end
Rabl.register!


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)

get "/api/notes.json" do
  @note = Note.all
  rabl :note
end

get "/api/notes/tag/:tags" do
  @tag = Tag.find_by(name: params[:tags])
  if @tag
    rabl :tag
  end
end


post "/api/notes" do
  note = Note.new(
  title: params[:title],
  body: params[:body]
  )

  params[:tags].split(',').each do |name|
    tag = Tag.find_or_create_by(name: name)
    note.tags << tag
  end

  if note.save
    @note = note
    rabl :note

  else
    status 400
    {errors: note.errors.full_messages.collect{ |e|
      {error: e}
    }}.to_json
  end
end
