require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:benji)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation | Thinkr.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@thinkr.com"], mail.from
    assert_match "Hi", mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test "password reset activation mail" do
    user = users(:benji)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset user
    assert_equal "Password Reset | Thinkr.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@thinkr.com"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end
end
