class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :note

  validates :tag, :note, presence: true

end
