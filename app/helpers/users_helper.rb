module UsersHelper

  def gravatar_for user, size = 150
    gravatar_path = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/" + gravatar_path + "size"
    image_tag gravatar_url, alt: user.name
  end
end
