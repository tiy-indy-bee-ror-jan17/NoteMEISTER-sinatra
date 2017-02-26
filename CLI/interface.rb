require 'HTTPary'

class Notify
  include HTTParty
  base_uri 'localhost:4567'

  def initialize(service, page)
    @options = { query: { site: service, page: page } }
  end

  def notes
    self.class.get("'/api/notes'", @options)
  end

  def notes_to_json
    self.class.get('/api/notes.json', @options)
  end
end

notify = Notify.new("???", 1)
puts notify.notes
puts notify.notes_to_json
