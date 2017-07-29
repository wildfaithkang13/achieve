module UsersHelper
  def show_follower_img(user)
    return image_tag(user.avatar, alt: user.name, :size => "150x150") if user.avatar?
    unless user.provider.blank?
      image_tag(user.image_url, alt: user.name, :size => "150x150")
    end
  end

  def show_followered_img(user)
    return image_tag(user.avatar, alt: user.name, :size => "150x150") if user.avatar?
    unless user.provider.blank?
      image_tag(user.image_url, alt: user.name, :size => "150x150")
    end
  end
end
