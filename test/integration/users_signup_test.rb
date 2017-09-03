require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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
    follow_redirect!
    assert_template 'users/show'
  end
end
