module AvatarHelper
  def avatar(user, options = {})
    if user.mc_username
      image = minotar_url user.mc_username, options
    else
      image = gravatar_url user.email, options
    end
    image_tag image, :alt => "Avatar" if image.present?
  end

  def gravatar_url(email, options = {})
    require 'digest/md5' unless defined?(Digest::MD5)
    md5 = Digest::MD5.hexdigest(email.to_s.strip.downcase)
    options[:s] = options.delete(:size) || 60
    options[:d] = options.delete(:default)
    options.delete(:d) unless options[:d]
    "#{request.ssl? ? 'https://secure' : 'http://www'}.gravatar.com/avatar/#{md5}?#{options.to_param}"
  end

  def minotar_url(ign, options = {})
    options[:type] ||= "helm" # or "avatar"
    options[:size] ||= 60
    "https://minotar.net/#{options[:type]}/#{CGI.escape(ign)}/#{options[:size]}.png"
  end
end