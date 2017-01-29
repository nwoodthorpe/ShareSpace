class RemoveContentFromMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :content, :string
  end
end
