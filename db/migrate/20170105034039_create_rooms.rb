class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.boolean :public_room, null: false, default: true
      t.boolean :locked, null: false, default: false
      t.string :short_url, null: false
      t.timestamps
    end
  end
end
