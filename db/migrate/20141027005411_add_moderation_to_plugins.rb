class AddModerationToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :approved, :boolean, default: false
    add_column :plugins, :denied, :boolean, default: false
  end
end
