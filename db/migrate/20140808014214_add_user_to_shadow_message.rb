class AddUserToShadowMessage < ActiveRecord::Migration
  def change
    add_column :shadow_messages, :user_id, :integer
    add_index :shadow_messages, :user_id
  end
end
