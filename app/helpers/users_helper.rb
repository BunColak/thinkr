module UsersHelper

  def gravatar_for user
    gravatar_path = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/" + gravatar_path + "?s=150"
    image_tag gravatar_url, alt: user.name
  end
end
