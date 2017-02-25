class Tagging < ActiveRecord::Base

  belongs_to :note
  belongs_to :tag

  validates :note, presence: true
  validates :tag, presence: true

end
