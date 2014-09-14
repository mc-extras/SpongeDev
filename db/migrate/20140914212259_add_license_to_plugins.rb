class AddLicenseToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :license, :string
    add_column :plugins, :custom_license, :string
    add_column :plugins, :custom_text, :string
  end
end
