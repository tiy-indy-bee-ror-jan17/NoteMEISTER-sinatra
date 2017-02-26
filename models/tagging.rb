require 'active_record'

class Tagging < ActiveRecord::Base

  belongs_to :note
  belongs_to :tag

  validates :note, presence: true
  validates :tag, presence: true


  def as_json(arg)
    {
      note: note,
      tag: tag
    }
  end

end
