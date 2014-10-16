class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string
    add_column :users, :username, :string
  end
end
