class FixImagemessageName < ActiveRecord::Migration[5.0]
  def change
    rename_column :image_messages, :url, :image
  end
end
