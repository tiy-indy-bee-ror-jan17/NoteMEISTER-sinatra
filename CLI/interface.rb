require 'tty'
require 'pry'
require 'HTTParty'

class Interface
  attr_accessor :prompt, :host, response

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

  def run
    while prompt.yes?("Would you like to do the http's?")


      user_choice = prompt.select( "choose an endpoint:",
        "GET /api/notes": "notes",
        "GET /api/notes/tag/?": "tag",
        "POST /api/notes": "post",
        "cancel": nil
        )

      result = case user_choice
              when "notes" then "/api/notes"
              when "tag" then gettag
              when "post" then getpost
              end

      #binding.pry
      response = HTTParty.get("#{host}#{result}") if result.is_a?(String)

      response = HTTParty.post("#{host}/api/notes", result) if result.is_a?(Hash)

      puts response
    end

    puts "goodbye!"
    response
  end

end

Interface.new.run
