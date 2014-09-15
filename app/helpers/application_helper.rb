module ApplicationHelper
  def active(page)
    if params[:controller].match(/^forem/) and page == "forums"
      return "active"
    end 
    return params[:controller] == page ? "active" : ""
  end

  def tab_active(tab, first = false)
    params[:view] == tab or (first and not params[:view]) ? "active" : ""
  end
end
