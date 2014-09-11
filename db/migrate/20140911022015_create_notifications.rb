class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.string :string
      t.string :url
      t.string :summary

      t.timestamps
    end
  end
end
