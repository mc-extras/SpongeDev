class CreateWikiWikis < ActiveRecord::Migration
  def change
    create_table :wiki_wikis do |t|
      t.timestamps
    end
  end
end
