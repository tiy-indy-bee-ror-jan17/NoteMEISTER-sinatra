class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :notes, through: :taggings

  def self.all_names
    self.all.map{ |tag| {name: tag.name} }
  end

  def as_json(_)
    to_jsonlike_hash = -> (note){ note.as_json(_) }
    Hash(
      name: name,
      notes: notes.map(&to_jsonlike_hash)
    )
  end

end
