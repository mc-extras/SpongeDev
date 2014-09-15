class AddPrimaryCategoryToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :primary_category, :string
  end
end
