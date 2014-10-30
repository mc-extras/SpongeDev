class PluginsController < ApplicationController
  include PluginsHelper
  include NotificationsHelper

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :require_admin, :only => [:approve, :deny]
  def index
    @tags = CATEGORIES

    @plugins = if params[:category]
      Plugin.tagged_with(params[:category])
    else
      Plugin.all
    end
    @plugins = @plugins.where(:approved => true)
    unless params[:api]
      @plugins = @plugins.page(params[:page])
    end
  end

  def show
    @plugin = Plugin.find(params[:id])
    @downloads = if @plugin.can_manage(current_user)
      @plugin.plugin_files.all
    else
      @plugin.plugin_files.where(:approved => true)
    end
    return redirect_to plugins_path, :alert => "This plugin is awaiting moderation, and can not be viewed right now." unless @plugin.can_view(current_user)
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

  def destroy
    @plugin = Plugin.find(params[:id])
    @plugin.destroy
    redirect_to plugins_path
  end

  def approve
    @plugin = Plugin.find(params[:plugin_id])
    @plugin.approved = true
    @plugin.save

    # Dispatch notifications
    current_user.send_message(@plugin.user, "Your plugin #{@plugin.name} has been approved.", "Your plugin has been approved.")

    redirect_to moderation_projects_path, :notice => "Successfully approved #{@plugin.name}."
  end

  def deny
    @plugin = Plugin.find(params[:plugin_id])
    @plugin.denied = true
    @plugin.save

    # Dispatch notifications
    current_user.send_message(@plugin.user, "Your plugin #{@plugin.name} has been denied.", "Your plugin has been denied.")

    redirect_to moderation_projects_path, :notice => "Successfully denied #{@plugin.name}."
  end

  def subscribe
    @plugin = Plugin.find(params[:plugin_id])
    subscribe_user(@plugin.subscriptions, current_user)
    return redirect_to @plugin, :notice => "Successfully subscribed to download updates for #{@plugin.name}."
  end

  def unsubscribe
    @plugin = Plugin.find(params[:plugin_id])
    unsubscribe_user(@plugin.subscriptions, current_user)
    return redirect_to @plugin, :notice => "Successfully unsubscribed from download updates for #{@plugin.name}."
  end

  private
  def plugins_params
    params.require(:plugin).permit(:name, { tag_list: [] }, :body, :summary, :license, :custom_license, :custom_text, :primary_category)
  end
end
