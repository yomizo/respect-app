class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :respect, null: false
      t.float :double, :lat, null: false
      t.float :double, :lng, null: false
      t.references :user, foregin_key: true, null: false
      t.string :comment

      t.timestamps
    end
  end
end
