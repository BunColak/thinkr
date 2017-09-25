require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  def setup
    @user = users(:benji)
    @thought = @user.thoughts.build(content: "Hello World!")
  end

  test "thought should be valid" do
    assert @thought.valid?
  end

  test "user_id must be present" do
    @thought.user_id = nil
    assert_not @thought.valid?
  end

  test "content must be present" do
    @thought.content = ""
    assert_not @thought.valid?
  end

  test "content must be smaller than 140 characters" do
    @thought.content = "a"*141
    assert_not @thought.valid?
  end

  test "order should be recent first" do
    assert_equal thoughts(:most_recent), Thought.first
  end

end
