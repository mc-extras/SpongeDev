module ApplicationHelper
  def active(page)
    if params[:controller].match(/^forem/) and page == "forums"
      return "active"
    end 
    return params[:controller] == page ? "active" : ""
  end
end
