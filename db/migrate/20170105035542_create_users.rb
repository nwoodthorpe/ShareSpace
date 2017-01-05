class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :room_id
      t.string :name
      t.datetime :last_active, null: false
      t.timestamps
    end
  end
end
