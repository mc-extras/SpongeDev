class CreatePluginPages < ActiveRecord::Migration
  def change
    create_table :plugin_pages do |t|
      t.string :title
      t.text :body
      t.integer :plugin_id

      t.timestamps
    end
  end
end
