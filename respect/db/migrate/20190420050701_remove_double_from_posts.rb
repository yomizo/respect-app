class RemoveDoubleFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :double, :float
  end
end
