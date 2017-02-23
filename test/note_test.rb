require_relative 'test_helper'

class NoteTest < JacquesTest

  def setup
    @note = build(:note)
    super
  end

  def test_validates_title
    @note.title = nil
    refute @note.save
    assert @note.errors.full_messages.include? "Title can't be blank"
  end

  def test_validates_body
    @note.body = nil
    refute @note.save
    assert @note.errors.full_messages.include? "Body can't be blank"
  end

  def test_has_taggings
    assert @note.save
    assert @note.respond_to? :taggings
    assert @note.taggings.to_a.is_a? Array
  end

  def test_has_tags
    assert @note.save
    assert @note.respond_to? :tags
    assert @note.tags.to_a.is_a? Array
  end

end
