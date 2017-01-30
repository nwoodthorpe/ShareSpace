class CreateImageMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :image_messages do |t|
      t.string :url, null: false
      t.timestamps
    end
  end
end
