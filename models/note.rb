class Note < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true

  def as_json(arg)
    {
      title: title,
      body: body,
      tags: tags.map { |t| {"name" => t.name} }
    }
  end
end
