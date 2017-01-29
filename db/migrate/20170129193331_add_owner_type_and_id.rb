class AddOwnerTypeAndId < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :content_klass, :string
    add_column :messages, :content_id, :integer
  end
end
