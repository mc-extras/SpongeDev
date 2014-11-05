class PluginFilesController < ApplicationController
  include PluginFilesHelper
  include NotificationsHelper

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :require_admin, :only => [:approve, :deny]
  def index
    @plugin = Plugin.find(params[:plugin_id])
    @downloads = if @plugin.can_manage(current_user)
      @plugin.plugin_files
    else
      @plugin.plugin_files.where(:approved => true)
    end

    @downloads = @downloads.order('created_at DESC')
    respond_to do |format|
      format.html
      format.json { render json: @downloads }
    end
  end

  def show
    @plugin = Plugin.find(params[:plugin_id])
    @download = PluginFile.find(params[:id])
    return redirect_to @plugin, :alert => "That download has yet to be approved by the moderation team." unless @download.can_view(current_user)
    respond_to do |format|
      format.html
      format.json { render json: @download }
    end
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
    @download = @plugin.plugin_files.find(params[:id])
    @download.destroy
    redirect_to plugin_plugin_files_path(@plugin)
  end

  def download
    @plugin = Plugin.find(params[:plugin_id])
    @download = @plugin.plugin_files.find(params[:plugin_file_id])
    @download.downloads += 1
    @download.save
    send_file @download.file.path
  end

  def approve
    @file = PluginFile.find(params[:plugin_file_id])
    @file.approved = true
    @file.save

    # Dispatch notifications
    current_user.send_message(@file.plugin.user, "A download for your plugin #{@file.plugin.name} has been approved.", "Your plugin download has been approved.")
    message_all(@file.plugin.user, @file.plugin.subscriptions, "I've uploaded a new download for my plugin #{@file.plugin.name}!", "New download for #{@file.plugin.name}.")

    redirect_to moderation_files_path, :notice => "Successfully approved a file."
  end

  def deny
    @file = PluginFile.find(params[:plugin_file_id])
    @file.destroy

    # Dispatch notifications
    current_user.send_message(@file.plugin.user, "A download for your plugin #{@file.plugin.name} has been denied.", "Your plugin download has been denied.")

    redirect_to moderation_files_path, :notice => "Successfully denied a file."
  end

  private
  def download_params
    params.require(:plugin_file).permit(:mc_version, :changelog, :notes, :name, :file, :release_type)
  end
end
