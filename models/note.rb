class Note < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :body, presence: true
  validates :title, presence: true



  def example_note
    {
      "title"       => title,
      "body"        => body,
      "tags"        => tags.map { |t| {"name" => t.name} }
    }
  end

end
