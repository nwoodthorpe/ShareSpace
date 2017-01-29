class CreateTextMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :text_messages do |t|
      t.string :content, null: false
      t.timestamps
    end
  end
end
