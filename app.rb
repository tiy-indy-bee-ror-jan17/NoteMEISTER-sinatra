require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'pry'
require 'ostruct'      #Enables use of OpenStruct
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

# #Returns the given tag with all it's related notes, first pass
# get '/api/notes/tag/:name' do
#   tag = Tag.find_by(name: params[:name])
#   tag_with_notes =
#       { name:  tag.name,
#         notes: tag.notes.collect do |a|
#                { title: a.title,
#                  body:  a.body,
#                  tags:  a.tags.collect do |z|
#                    { name: z.name }
#                  end
#                      }
#         end
#       }
#   tag_with_notes.to_json
# end

#Returns the given tag with all it's related notes
get '/api/notes/tag/:name' do
  tag = Tag.find_by(name: params[:name])
  tag_with_notes =
      { name:  tag.name,
        notes: tag.notes.collect do |note|
                note.hash_format_title_body_tags
        end
      }
  tag_with_notes.to_json
end




post '/api/notes' do

  new_note = Note.create(title: params[:title],
                        body: params[:body])
  if new_note.save
    array = params[:tags].split(",")
    array.each do |x|
      new_tag = Tag.create!(name: x)
      Tagging.create!(note_id: new_note.id,
                      tag_id:  new_tag.id)
    end
    new_note.hash_format_title_body_tags.to_json
  else

    status 400
    #Format of error Jacques expects
    #      `{"errors" : [{"error" : "Title can't be blank""}]}`
    #  in previous examples, chris used OpenStruct...
    #  @error = OpenStruct.new({code: 400, message: @lipsum.errors.full_messages.first})
#      "title"       => title,

    # new_note.errors.full_messages contains an array of error strings
    #    i.e. ["Title can't be blank", "Body can't be blank"]
    # jacques wants an array of hashes prefaced with the string (key) of "error"
    #    i.e. [{"error"=>"Title can't be blank"}, {"error"=>"Body can't be blank"}]

    hasherize_the_array1 = new_note.errors.full_messages.map do |x|
                            { "error" => x }
                          end
#    hasherize_the_array2 =

# enumerator = %w(one two three).each
# puts enumerator.class # => Enumerator
#
# enumerator.each_with_object("foo") do |item, obj|
#   puts "#{obj}: #{item}"
# end
#
# # foo: one
# # foo: two
# # foo: three

    error = {"errors" => hasherize_the_array1 }
    error.to_json

  end
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
