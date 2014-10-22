class AddRegistrationTokens < ActiveRecord::Migration
  def change
    create_table :registration_tokens do |t|
      t.string :uuid
      t.string :token

      t.timestamps
    end
  end
end
