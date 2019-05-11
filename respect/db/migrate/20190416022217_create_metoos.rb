class CreateMetoos < ActiveRecord::Migration[5.2]
  def change
    create_table :metoos do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false

      t.timestamps

      t.index :user_id
      t.index :post_id
      t.index [:user_id, :post_id], unique true
    end
  end
end
