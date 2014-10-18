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
    link_to user.username, user
  end
end
