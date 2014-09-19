class CreateWikiPages < ActiveRecord::Migration
  def change
    create_table :wiki_pages do |t|
      t.text :content
      t.string :title
      
      t.timestamps
    end
  end
end
