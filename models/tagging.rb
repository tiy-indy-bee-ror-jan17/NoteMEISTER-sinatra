class Tagging < ActiveRecord::Base

  validates :note, presence: true
  validates :tag, presence: true

  belongs_to :tag
  belongs_to :note

end
