class PluginPagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @plugin = Plugin.find(params[:plugin_id])
    @pages = @plugin.plugin_pages
  end

  def show
    @plugin = Plugin.find(params[:plugin_id])
    @page = PluginPage.find(params[:id])
  end

  def new
    @plugin = Plugin.find(params[:plugin_id])
    @page = @plugin.plugin_pages.build
  end

  def edit
    @plugin = Plugin.find(params[:plugin_id])
    @page = PluginPage.find(params[:id])
  end

  def create
    @plugin = Plugin.find(params[:plugin_id])
    @page = @plugin.plugin_pages.create(plugin_page_params)
    if @page.save
      redirect_to plugin_plugin_pages_path(@plugin)
    else
      render 'edit'
    end
  end

  def update
    @plugin = Plugin.find(params[:plugin_id])
    @page = PluginPage.find(params[:id])
    respond_to do |format|
      if @page.update(plugin_page_params)
        format.html { redirect_to [@plugin, @page], notice: 'Wiki page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = PluginPage.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.html { redirect_to plugin_pages_url, notice: 'Wiki page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def plugin_page_params
      params.require(:plugin_page).permit(:title, :body, :plugin_id)
    end
end
