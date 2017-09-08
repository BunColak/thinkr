require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:benji)
    @mahmut = users(:mahmut)
  end

  test "unsuccessful edits must not be saved" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:{user: {
      name: "",
      email: "foobar@",
      password: "foo",
      password_confirmation: "bar"
      }}
    assert_template 'users/edit'
  end

  test "successful edits must be saved" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    edited_name = "Mahmut"
    edited_email = "mahmut@gmail.com"

    patch user_path(@user), params:{ user: {
      name: edited_name,
      email: edited_email,
      password: "",
      password_confirmation: ""
      }}

    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal edited_name, @user.name
    assert_equal edited_email, @user.email
  end

  test "user cannot edit another user" do
    log_in_as @mahmut
    get edit_user_path @user
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "user cannot update another user" do
    log_in_as @mahmut
    get edit_user_path @user
    patch user_path(@user), params:{
      user: {
        name: @user.name,
        email: @user.name,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "non admin users cannot edit users" do
    log_in_as @mahmut
    assert_not @mahmut.admin?
    patch user_path @user, params:{
      user: {
        name: @user.name,
        email: @user.name,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "non admin should not be able to delete" do
    log_in_as @mahmut
    assert_not @mahmut.admin?
    assert_no_difference 'User.count' do
      delete user_path @mahmut
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "admin should not be able to delete" do
    log_in_as @user
    assert @user.admin?
    assert_difference 'User.count', -1 do
      delete user_path @mahmut
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

end
