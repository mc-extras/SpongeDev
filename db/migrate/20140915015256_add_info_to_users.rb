class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :plugins, :gender, :string
    add_column :plugins, :location, :string
  end
end
