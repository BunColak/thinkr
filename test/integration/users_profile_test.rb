require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:benji)
  end

  test "profile page" do
    log_in_as @user
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.thoughts.count.to_s, response.body
  end
end
