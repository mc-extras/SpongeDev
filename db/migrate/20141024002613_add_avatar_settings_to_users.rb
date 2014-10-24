class AddAvatarSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_serve, :string, :default => "Gravatar"
  end
end
