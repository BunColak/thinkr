require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(thought_id: thoughts(:orange).id, liked_id: users(:benji).id)
  end

  test "like should be valid" do
    assert @like.valid?
  end

  test "thought id should be present" do
    @like.thought_id = nil
    assert_not @like.valid?
  end

  test "liked_id should be present" do
    @like.liked_id = nil
    assert_not @like.valid?
  end
end
