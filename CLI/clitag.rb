require_relative 'clinote'

class Tag
  attr_accessor :name, :notes

  def self.parse(json)
    data = JSON.parse(json, symbolize_names: true)
    data[:notes] = Note.parse(data[:notes])
    new(data)
  end

  def initialize(name:, notes: [])
    @name = name
    @notes = notes
  end

  def to_s
    list = ""
    notes.each{ |n| list += "#{n}"}
    "Tag: #{name}\nNotes:\n#{list}"
  end

end
