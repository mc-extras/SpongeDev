class AddPluginIdToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :plugin_id, :integer
  end
end
