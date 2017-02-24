require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'
require_relative 'models/note'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/development.sqlite3'
)


get '/api/notes.json' do
  notes = Note.all
  notes_with_tags = notes.collect do |x|
    x.example_note
  end
  notes_with_tags.to_json
end

get '/api/notes_long_way.json' do
  notes = Note.all
  notes_with_tags = notes.collect do |x|
    { title:  x.title,
      body:   x.body,
      tags:   x.tags.collect do |z| { name: z.name } end
    }
  end
  notes_with_tags.to_json
end

#Returns the given tag with all it's related notes
get '/api/notes/tag/:name' do


  tag = Tag.find_by(name: params[:name])
binding.pry
  tag_with_notes =
      { name:  tag.name,
        notes: tag.notes.collect do |a|
               { title: a.title,
                 body:  a.body,
                 tags:  a.tags.collect do |z|
                   { name: z.name }
                 end
                     }
        end
      }

  tag_with_notes.to_json


end










post '/api/notes' do

end



#  a = ["L","Z","J"].collect{|x| puts x.succ}
#  notes.collect  instead of each because I would have to manually
#        do a bunch of stuff
# defintion of collect (and map):  collect creates
# a new array and pushes the results of the block into it
#     hash representation of my
#  | x|  do    x.example_note
#
#  same as as_json example in lorem.rb day4 homework_work w4 d4
#
#

#   notes = Note.all
#   if notes and notes.count != 0
#       binding.pry
#       notes.to_json
#   else
#     status 404
#   end
# end

# table_entry = Ipsum.find_by(identifier: params['type'])
# if table_entry
#   table_entry.paragraph
# else
#   # How to get the Sinatra doesn't know this ditty message -- Chris
#   # couldn't find easily either, he said some rabbit holes go too deep
#   status 404
# end
