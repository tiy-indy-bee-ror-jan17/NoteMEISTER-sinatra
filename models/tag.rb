class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :restrict_with_error
  has_many :notes, through: :taggings

  validates :name, presence: true, uniqueness: true

  def as_json(arg={})
    if arg[:include] == :notes
      {
        name: name,
        notes: notes
      }
    else
      {name: name}
    end
  end

end
