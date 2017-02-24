

class Tag < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true

    has_many :taggings
    has_many :notes, through: :taggings

    def notes_with_a_certain_tag
      {
        "name"       => name,
        "body"       => body,
        "notes"      => notes.example_note
      }
    end

end
