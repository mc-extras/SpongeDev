class AddStatsToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :downloads, :integer, :default => 0, :nullable => false
    add_column :plugins, :views, :integer, :default => 0, :nullable => false
  end
end
