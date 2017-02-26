require 'active_record'

class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :notes, through: :taggings

  validates :name, presence: true, uniqueness: true

  def as_json(arg = nil)
    {
      name: name,
      notes: notes.map { |notes| notes.as_json }
    }
  end

end
