require 'active_record'

class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :notes, through: :taggings

  def as_json(arg = nil)
      {
        name: name,
        notes: notes.collect { |note| note.as_json }
      }
  end


end
