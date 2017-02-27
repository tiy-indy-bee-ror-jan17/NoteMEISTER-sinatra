class Note < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, :body, presence: true

  def as_json(arg={})
    {
      title: title,
      body: body,
      tags: tags
    }
  end

end
