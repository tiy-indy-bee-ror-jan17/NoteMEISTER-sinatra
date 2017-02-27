class Note < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments


  validates :title, presence: true
  validates :body, presence: true


end
