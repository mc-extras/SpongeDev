module AvatarHelper
  def avatar(user, options = {})
    if user.mc_uuid and user.avatar_serve == "Crafatar"
      image = crafatar_url user.mc_uuid, options
    else
      image = gravatar_url user.email, options
    end
    image_tag image, :alt => "Avatar", class: 'avatar' if image.present?
  end

  def gravatar_url(email, options = {})
    require 'digest/md5' unless defined?(Digest::MD5)
    md5 = Digest::MD5.hexdigest(email.to_s.strip.downcase)
    options[:s] = options.delete(:size) || 60
    options[:d] = options.delete(:default)
    options.delete(:d) unless options[:d]
    "#{request.ssl? ? 'https://secure' : 'http://www'}.gravatar.com/avatar/#{md5}?#{options.to_param}"
  end

  def crafatar_url(uuid, options = {})
    options[:type] ||= "avatar" # or "avatar"
    options[:size] ||= 60
    "https://skins.jake0oo0.me/avatars/#{CGI.escape(uuid)}?size=#{options[:size]}"
  end
end