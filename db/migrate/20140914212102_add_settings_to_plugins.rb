class AddSettingsToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :allow_comments, :boolean, :default => true, :nullable => false
  end
end
