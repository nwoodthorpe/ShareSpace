class AddPasswordToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :password, :string
  end
end
