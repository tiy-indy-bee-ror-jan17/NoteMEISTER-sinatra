class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :note
  validates :note, presence: true
  validates :tag, presence: true
end
