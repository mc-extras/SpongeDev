class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id
      t.integer :subscribable_id
      t.string :subscribable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
