class PluginsController < ApplicationController
  include PluginsHelper
  include NotificationsHelper

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :require_admin, :only => [:approve, :deny]
  before_filter :set_plugin, :only => [:show, :edit, :destroy, :approve, :deny, :subscribe, :unsubscribe]
  
  def index
    @tags = CATEGORIES
    if params[:search]
      @plugins = Plugin.search(params[:search])
    else
      @plugins = if params[:category]
        Plugin.tagged_with(params[:category])
      else
        Plugin.all
      end
    end
    @plugins = @plugins.where(:approved => true)
    unless params[:api]
      @plugins = @plugins.page(params[:page])
    end
  end

  def show
    @comments = Kaminari.paginate_array(@plugin.comments.reject(&:new_record?)).page(params[:comments]).per(5)
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
  end

  def destroy
    @plugin.destroy
    redirect_to plugins_path, :notice => "Successfully deleted the plugin."
  end

  def approve
    @plugin.approved = true
    @plugin.save

    # Dispatch notifications
    current_user.send_message(@plugin.user, "Your plugin #{@plugin.name} has been approved.", "Your plugin has been approved.")
    redirect_to moderation_projects_path, :notice => "Successfully approved #{@plugin.name}."
  end

  def deny
    @plugin.denied = true
    @plugin.save

    # Dispatch notifications
    current_user.send_message(@plugin.user, "Your plugin #{@plugin.name} has been denied.", "Your plugin has been denied.")
    redirect_to moderation_projects_path, :notice => "Successfully denied #{@plugin.name}."
  end

  def subscribe
    subscribe_user(@plugin.subscriptions, current_user)
    return redirect_to @plugin, :notice => "Successfully subscribed to download updates for #{@plugin.name}."
  end

  def unsubscribe
    unsubscribe_user(@plugin.subscriptions, current_user)
    return redirect_to @plugin, :notice => "Successfully unsubscribed from download updates for #{@plugin.name}."
  end

  private
  def set_plugin
    @plugin = Plugin.find(params[:id] || params[:plugin_id])
  end

  def plugins_params
    params.require(:plugin).permit(:name, { tag_list: [] }, :body, :summary, :license, :custom_license, :custom_text, :primary_category)
  end
end
