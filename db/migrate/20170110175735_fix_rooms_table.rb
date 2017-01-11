class FixRoomsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :encrypted_password, :string
    add_column :rooms, :salt, :string
    remove_column :rooms, :password
  end
end
