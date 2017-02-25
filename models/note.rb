
class Note < ActiveRecord::Base

#  validates :title, presence: true
# added uniqueness to look at errors better
  validates :title, presence: true, uniqueness: true
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

  def hash_format_title_body_tags
    {
      "title"       => title,
      "body"        => body,
      "tags"        => tags.map { |t| {"name" => t.name} }
    }
  end

end
