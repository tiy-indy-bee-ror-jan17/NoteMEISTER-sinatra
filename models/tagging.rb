class Tagging < ActiveRecord::Base

  belongs_to :note
  belongs_to :tag

  after_destroy :orphaned_tag

  validates :tag, presence: true
  validates :note, presence: true

  def orphaned_tag
    tag.destroy
  end

end
