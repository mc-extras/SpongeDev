class AddTypeToPluginFiles < ActiveRecord::Migration
  def change
    add_column :plugin_files, :release_type, :string
  end
end
