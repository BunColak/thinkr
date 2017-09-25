require 'test_helper'

class ThoughtsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @thought = thoughts(:orange)
  end

  test "should redirect to login if not logged in" do
    assert_no_difference 'Thought.count' do
      post thoughts_path, params: {
        thought: {
          content: "Test content"
        }
      }
    end
    assert_redirected_to login_path
  end

  test "should not destroy when not logged in" do
    assert_no_difference 'Thought.count' do
      delete thought_path @thought
    end
    assert_redirected_to login_path
  end
end
