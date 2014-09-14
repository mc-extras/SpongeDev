class CreateInfractions < ActiveRecord::Migration
  def change
    create_table :infractions do |t|
      t.string :reason

      t.timestamps
    end
  end
end
