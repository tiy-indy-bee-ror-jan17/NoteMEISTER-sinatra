class Tagging < ActiveRecord::Base

  validates :note_id, presence: true
  validates :tag_id, presence: true

  belongs_to :tag
  belongs_to :note

end
