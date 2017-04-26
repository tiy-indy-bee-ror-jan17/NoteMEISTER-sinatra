require 'active_record'
require 'sqlite3'

class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :note

  validates :tag, presence: true
  validates :note, presence: true

end
