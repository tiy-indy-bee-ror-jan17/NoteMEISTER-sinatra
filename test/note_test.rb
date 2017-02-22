require_relative 'test_helper'

class NoteTest < JacquesTest

  def setup
    @subject = Note.new
    super
  end

  def test_associations
    must have_many :taggings
    must have_many :tags
  end

  def test_validations
    must validate_presence_of :title
    must validate_presence_of :body
  end

end
