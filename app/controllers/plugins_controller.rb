class PluginsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @tags = Plugin.tag_counts_on("tags")

    @plugins = if params[:category]
      Plugin.tagged_with(params[:category])
    else
      Plugin.all
    end
  end

  def show
    @plugin = Plugin.find(params[:id])
  end

  def new
    @plugin = Plugin.new
  end

  def create
    @plugin = Plugin.create(plugins_params)
    @plugin.user = current_user
    if @plugin.save
      redirect_to @plugin
    else
      render 'edit'
    end
  end

  def edit
    @plugin = Plugin.find(params[:id])
  end

  private
  def plugins_params
    params.require(:plugin).permit(:name, { tag_list: [] }, :body, :summary, :license, :custom_license, :custom_text)
  end
end
