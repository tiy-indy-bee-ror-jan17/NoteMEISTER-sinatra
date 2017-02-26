class Note
  attr_accessor :title, :body, :tags

  def self.parse(json)
    data = json.is_a?(Array) ? json : JSON.parse(json, symbolize_names: true)
    data.map{ |n| new(n) }
  end

  def initialize(title:, body:, tags: [])
    @title = title
    @body = body
    @tags = tags
  end

  def to_s
    list = ""
    tags.each{ |t| list += "#{t[:name]}, "}
    "\nNOTE: #{title} (#{list})\nTEXT: #{body}\n"
  end

end
