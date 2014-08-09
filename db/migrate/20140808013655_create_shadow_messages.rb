class CreateShadowMessages < ActiveRecord::Migration
  def change
    create_table :shadow_messages do |t|
      t.text :body
      t.integer :ttl

      t.timestamps
    end
  end
end
