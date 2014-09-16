class AddDownloadsToPluginFiles < ActiveRecord::Migration
  def change
    add_column :plugin_files, :downloads, :integer, default: 0
  end
end
