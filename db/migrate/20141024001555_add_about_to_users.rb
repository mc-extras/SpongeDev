class AddAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :github, :string
    add_column :users, :location, :string
    add_column :users, :gender, :string
  end
end
