class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.boolean :read

      t.timestamps
    end
  end
end
