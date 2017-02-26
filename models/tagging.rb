# tagging.rb
require 'active_record'

class Tagging < ActiveRecord::Base
  belongs_to  :note
  belongs_to  :tag
  validates   :note, presence: true
  validates   :tag,  presence: true

  def as_json(tagging=nil) {
    "note"       => tagging.note,
    "tag"        => tagging.tag,
    "tags"       => note.tags.map { |t| {"name" => t.name} }
    }
  end

end
