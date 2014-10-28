class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.string :plugin_name
      t.string :file_name
      t.string :action
      t.boolean :read, default: false
      t.time :read_at
      t.integer :user_id
      t.integer :subscription_id

      t.timestamps
    end
  end
end
