require 'active_record'

class Note < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true

  has_many :taggings
  has_many :tags, through: :taggings




end
