require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  def setup
    @user = users(:benji)
  end

  test "must be logged in to see all users" do
    get users_path
    assert_redirected_to login_path
  end

  test "must login before seeing user" do
    get user_path @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "must login before editing user" do
    get edit_user_path @user
    patch user_path, params: {
      user: {
        name: @user.name,
        email: @user.email,
        password: "valid_password",
        password_confirmation: "valid_password"
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "users path must have pagination" do
    log_in_as @user
    get users_path
    assert_template 'users/index'
    assert_select 'nav.pagination'
    User.paginate(page: 1, per_page: "10").each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
