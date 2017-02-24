require 'active_record'
require 'sqlite3'

class Note < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true

  has_many :tags, through: :taggings
  has_many :taggings

  def find_tag_name
    { title: title, body: body, tags: tags.map { |tag| {name: tag.name} } }
  end

end
