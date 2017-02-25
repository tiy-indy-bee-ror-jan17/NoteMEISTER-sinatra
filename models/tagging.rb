class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :note

  validates :tag_id, presence: true
  validates :note_id, presence: true

end
