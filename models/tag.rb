class Tag < ActiveRecord::Base

has_many :taggings
has_many :notes, through: :taggings

validates :name, uniqueness: true


end
