class Note < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true

  has_many :taggings
  has_many :tags, through: :taggings

  def as_json(_)
    Hash( #this situation doesn't seem to be in the styleguide, but I really think bare returning hashes ought to be written out lexically, given Ruby's forgiveness of whitespace and potential confusion with blocks
      title: title,
      body: body,
      tags: tags.all_names
    )
  end

  class << self
    alias :list :all
  end

end
