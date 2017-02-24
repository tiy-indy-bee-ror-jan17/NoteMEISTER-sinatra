
class Note < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true

  has_many :taggings
  has_many :tags, through: :taggings

#instance method when I call Note.example_note I get a note
#in this format

  def example_note
    {
      "title"       => title,
      "body"        => body,
      "tags"        => tags.map { |t| {"name" => t.name} }
    }
  end


end
