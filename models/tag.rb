require 'active_record'
require 'sqlite3'


class Tag < ActiveRecord::Base

  has_many :notes, through: :taggings
  has_many :taggings

  validates :name, presence: true, uniqueness: true

end
