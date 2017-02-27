class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :notes, through: :taggings

  def self.all_names
    self.all.map{ |tag| {name: tag.name} }
  end

  def as_json(_)
    to_jsonlike_hash = -> (note){ note.as_json(_) }
    Hash( #this situation doesn't seem to be in the styleguide, but I really think bare returning hashes ought to be written out lexically, given Ruby's forgiveness of whitespace and potential confusion with blocks
      name: name,
      notes: notes.collect(&to_jsonlike_hash)
    )
  end

end
