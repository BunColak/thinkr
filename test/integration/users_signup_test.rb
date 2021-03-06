require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "user must not be saved if invalid" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params:{
        user:{
           name: "",
           email: "exa@foo",
           password: "foo",
           password_confirmation: "fooba"
         }
        }
    end
    assert_template 'users/new'
  end

  test "user must be saved if valid" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params:{
        user:{
           name: "Example User",
           email: "user@Example.com",
           password: "foobar",
           password_confirmation: "foobar"
         }
        }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
