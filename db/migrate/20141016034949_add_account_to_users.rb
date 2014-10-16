class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mc_uuid, :string
    add_column :users, :mc_username, :string
  end
end
