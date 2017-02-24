require_relative 'test_helper'
require          'pry'

#--------------------
# JSON.parse parses a JSON string, constructing the JavaScript value
#            or object described by the string
# JSON.stringify creates a JSON string out of an object/array, they are opposites
#            of one another
#

class ExplorerTest < JacquesTest
  def setup
    10.times do
      FactoryGirl.create(:note_with_tags)
    end
    super
  end

  def test_it_should_return_the_proper_list
    get '/api/notes.json'
    assert_equal 200, last_response.status
    json = JSON.parse(last_response.body)
    assert json.length == 10
  end

  def test_it_should_be_in_the_correct_format
    get '/api/notes.json'
    json = JSON.parse(last_response.body)
    assert_equal example_note(Note.first), json.first
  end

  def test_it_should_be_in_the_correct_format_long_way_nancy_understanding
    get '/api/notes_long_way.json'
    json = JSON.parse(last_response.body)
    assert_equal example_note(Note.first), json.first
  end

#------------------------------------
# This is testing that all notes with a given tag are returned
#
  def test_tag_lists_are_correct
    note = Note.first
    get "/api/notes/tag/#{note.tags.first.name}"
    json = JSON.parse(last_response.body)
    assert_equal note.tags.first.name, json['name']
    assert_equal example_note(Note.first), json['notes'].first
  end

  # def test_tag_create_is_correct
  #
  #   post '/api/notes',
  #     {
  #       title:  "My created post",
  #       body:   "My created body",
  #       tags:   "api, machine, first"
  #     }
  #   json = JSON.parse(last_response.body)
  #   assert_equal "My created post", json['title']
  #   assert_equal 11, Note.count
  #   assert_equal 3, json['tags'].length
  # end
  #
  # def test_improper_note
  #   puts "in test_improper_note"
  #
  #   post '/api/notes',
  #     {
  #       title:  "",
  #       body:   "My created body",
  #       tags:   "api, machine, first"
  #     }
  #
  #   assert_equal 400, last_response.status
  #   json = JSON.parse(last_response.body)
  #   assert_equal "Title can't be blank", json['errors'].first['error']
  # end


  private

  def example_note(note)
    {
      "title"       => note.title,
      "body"        => note.body,
      "tags"        => note.tags.map { |t| {"name" => t.name} }
    }
  end

end
