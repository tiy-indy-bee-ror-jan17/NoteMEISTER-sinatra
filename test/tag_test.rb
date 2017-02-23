require_relative 'test_helper'

class TagTest < JacquesTest

  def setup
    @tag = build(:tag)
    super
  end

  def test_validates_name_presence
    @tag.name = nil
    refute @tag.save
    assert @tag.errors.full_messages.include? "Name can't be blank"
  end

  def test_validates_name_uniqueness
    tag2 = @tag.dup
    @tag.save!
    refute tag2.save
    assert tag2.errors.full_messages.include? "Name has already been taken"
  end

  def test_has_taggings
    assert @tag.save
    assert @tag.respond_to? :taggings
    assert @tag.taggings.to_a.is_a? Array
  end

  def test_has_tags
    assert @tag.save
    assert @tag.respond_to? :notes
    assert @tag.notes.to_a.is_a? Array
  end

end
