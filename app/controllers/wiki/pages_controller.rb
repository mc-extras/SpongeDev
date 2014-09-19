class Wiki::PagesController < ApplicationController
  def show
    @wiki = Wiki::Wiki.find(params[:wiki_id])
    @page = @wiki.pages.find(params[:page_id])
  end
  
  def new
    @page = Wiki::Wiki.find(params[:wiki_id]).new
  end

  def create
    @page = Wiki::Wiki.find(params[:wiki_id]).create(page_params)
    if @page.save
      redirect_to @page
    else
      render 'edit'
    end
  end

  def edit
    @paeg = Wiki::Page.find(params[:page_id])
  end

  private
  def page_params
    params.require(:page, :content, :title)
  end
end
