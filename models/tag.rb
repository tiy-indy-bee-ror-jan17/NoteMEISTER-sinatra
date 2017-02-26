# tag.rb
require 'active_record'

class Tag < ActiveRecord::Base
  has_many  :taggings
  has_many  :notes, through:  :taggings
  validates :name,  presence: true
  validates_uniqueness_of :name

  def as_json(_) {
    "name"       => name,
    "notes"      => notes.map{|x| x.as_json(_)}
    }
  end

end
