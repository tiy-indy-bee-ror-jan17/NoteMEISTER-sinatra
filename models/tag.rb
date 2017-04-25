class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :notes, through: :taggings
  validates :name, presence: true, uniqueness: true

  def as_json(arg = nil) {
    "name"        => name,
    "notes"      => notes.collect {|n| n.as_json}
  }
  end
end
