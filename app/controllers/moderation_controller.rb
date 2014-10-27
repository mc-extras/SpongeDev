class ModerationController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  
  def projects
    @projects = Plugin.where(:approved => false).where(:denied => false)
  end

  def files
    @files = PluginFile.where(:approved => false)
  end
end
