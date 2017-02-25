# tag.rb
require 'active_record'

class Tag < ActiveRecord::Base
  has_many  :taggings
  has_many  :notes, through:  :taggings
  validates :name,  presence: true
  validates_uniqueness_of :name

  # def as_json(tag=nil) {
  #   "name"       => tag.name,
  #   "body"        => note.body,
  #   "tags"        => note.tags.map { |t| {"name" => t.name} }
  #   }
  # end

end
