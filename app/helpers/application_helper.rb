module ApplicationHelper
  def active(page)
    return params[:controller] == page ? "active" : ""
  end

  def tab_active(tab, first = false)
    params[:view] == tab or (first and not params[:view]) ? "active" : ""
  end

  def is_admin?(user=current_user)
    user and user.admin?
  end

  def require_admin
    redirect_to root_path, :alert => "No permission." unless is_admin?
  end

  def profile_link(user)
    link_to user.username, user_path(user)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def ago(time)
    if time
      content_tag :time, title: time.strftime("%e %b %Y, %H:%M %Z"), datetime: time.to_datetime.rfc3339 do
        time_ago_in_words(time) + " ago"
      end
    end
  end
end
