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

  test "should be able to follow and unfollow other users" do
    benji = users(:benji)
    mahmut = users(:mahmut)
    benji.follow mahmut
    assert benji.following? mahmut
    assert mahmut.followers.include? benji
    benji.unfollow mahmut
    assert_not benji.following? mahmut
  end

  test "feed should have the right posts" do
    michael = users(:benji)
    archer = users(:huseyin)
    lana = users(:mahmut)
    # Posts from followed user
    lana.thoughts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.thoughts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.thoughts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

end
