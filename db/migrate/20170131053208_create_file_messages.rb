class CreateFileMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :file_messages do |t|
      t.string :file, null: false
      t.timestamps
    end
  end
end
