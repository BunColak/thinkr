require 'test_helper'

class LoginUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:benji)
  end

  test "flash should appear once" do
    get login_path
    assert_template 'sessions/new'
    post login_path params:{session: { email: "", password:""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "layout should be correct" do
    get login_path
    post login_path params: {session: { email: @user.email, password: "password" }}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
