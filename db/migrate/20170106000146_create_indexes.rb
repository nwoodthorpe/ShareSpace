class CreateIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :rooms, :short_url
    add_index :users, :room_id
  end
end
