class PluginFilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @plugin = Plugin.find(params[:plugin_id])
    @downloads = @plugin.plugin_files
  end

  def show
    @plugin = Plugin.find(params[:plugin_id])
    @download = PluginFile.find(params[:id])
  end

  def new
    @plugin = Plugin.find(params[:plugin_id])
    @download = @plugin.plugin_files.build
  end

  def create
    @plugin = Plugin.find(params[:plugin_id])
    @download = @plugin.plugin_files.create(download_params)
    if @download.save
      redirect_to plugin_plugin_files_path(@plugin)
    else
      render 'edit'
    end
  end
  
  def destroy
    @plugin = Plugin.find(params[:plugin_id])
    @download = PluginFile.find(params[:id])
    @download.destroy
    redirect_to plugin_plugin_files_path(@plugin) 
  end

  private
  def download_params
    params.require(:plugin_file).permit(:mc_version, :changelog, :notes, :name, :file, :release_type)
  end
end
