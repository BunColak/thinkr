require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
     @user = User.new name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar"
   end

  test "user should be vaild" do
    assert @user.valid?
  end

  # Name tests start
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should be greater than 2" do
    @user.name = "a"*2
    assert_not @user.valid?
  end

  test "name should be smaller than 31" do
    @user.name = "a"*31
    assert_not @user.valid?
  end
  # Name tests end

  # Email tests start
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should be greater than 6" do
    @user.email = "a@n.co"
    assert_not @user.valid?
  end

  test "email should be smaller than 41" do
    @user.email = "a"*36 + "@n.co"
    assert_not @user.valid?
  end

  test "email should not be invalid" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?
    end
  end

  test "emails should be valid" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?
    end
  end

  test "emails should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "if user is destroyed, thoughts should do so" do
    @user.save
    @user.thoughts.create!(content: "Hello!")
    assert_difference 'Thought.count', -1 do
      @user.destroy
    end
  end

end
