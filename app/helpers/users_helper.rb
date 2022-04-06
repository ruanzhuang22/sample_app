module UsersHelper
  def gravatar_for user, size: Settings.gravatar.size.default
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "#{Settings.gravatar.base_url}/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.email, class: "gravatar"
  end
end
