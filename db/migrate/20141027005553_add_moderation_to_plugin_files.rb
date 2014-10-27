class AddModerationToPluginFiles < ActiveRecord::Migration
  def change
    add_column :plugin_files, :approved, :boolean, default: false
  end
end
