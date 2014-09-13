class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string :name
      t.text :body
      t.string :summary
      t.timestamps
    end
  end
end
