class PluginsController < ApplicationController
  def index
    @plugins = Plugin.all
    @tags = ActsAsTaggableOn::Tag.all
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
    params.require(:plugin).permit(:name, :categories_list, :body)
  end
end
