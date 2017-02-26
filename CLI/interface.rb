require 'tty'
require 'pry'
require 'HTTParty'

require_relative 'clinote'
require_relative 'clitag'

class Interface
  attr_accessor :prompt, :host, :response

  def initialize
    @prompt = TTY::Prompt.new
    @host = 'http://localhost:4567'
    @response = nil
  end



  def gettag
    tag = prompt.ask("what tag are you requesting?")
    "/api/notes/tag/#{tag}"
  end

  def getpost
    prompt.collect do
      key(:query) do
        key(:title).ask('title of note?')
        key(:body).ask('body of note?')
        key(:tags).ask('tags for note?')
      end
    end
  end

  def process(type)
    case type
    when "notes"  then Note.parse(response)
    when "tag"    then Tag.parse(response)
    when "post"   then Note.parse("[#{response}]").first
    end
  end

  def run

    user_choice = prompt.select( "choose an endpoint:",
      "GET /api/notes.json": "notes",
      "GET /api/notes/tag/?": "tag",
      "POST /api/notes": "post",
      "cancel": nil
      )

    result = case user_choice
            when "notes" then "/api/notes.json"
            when "tag" then gettag
            when "post" then getpost
            end

    self.response = HTTParty.get("#{host}#{result}") if result.is_a?(String)

    self.response = HTTParty.post("#{host}/api/notes", result) if result.is_a?(Hash)

    puts process(user_choice)
  end

end

puts Interface.new.run
