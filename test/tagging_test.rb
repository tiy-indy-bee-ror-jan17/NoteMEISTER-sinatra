require_relative 'test_helper'

class TaggingTest < JacquesTest

  def setup
    @tagging = Tagging.new
    super
  end

  def test_validates_presence_of_tag
    note = create(:note)
    @tagging.note = note
    refute @tagging.save
    assert @tagging.errors.full_messages.include? "Tag can't be blank"
  end

  def test_validates_presence_of_note
    tag = create(:tag)
    @tagging.tag = tag
    refute @tagging.save
    assert @tagging.errors.full_messages.include? "Note can't be blank"
  end

end
