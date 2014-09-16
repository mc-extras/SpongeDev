class CreatePluginFiles < ActiveRecord::Migration
  def change
    create_table :plugin_files do |t|
      t.string :name
      t.string :mc_version
      t.text :changelog
      t.text :notes
      t.integer :plugin_id
      t.string :file

      t.timestamps
    end
  end
end
