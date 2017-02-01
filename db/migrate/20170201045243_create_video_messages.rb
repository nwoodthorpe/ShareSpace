class CreateVideoMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :video_messages do |t|
      t.string :video, null: false
      t.timestamps
    end
  end
end
