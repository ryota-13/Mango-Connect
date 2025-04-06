class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follower_id, null: false 
      t.integer :followed_id, null: false 
      t.timestamps

      t.index :follower_id  # follower_idにインデックスを追加
      t.index :followed_id  # followed_idにインデックスを追加
    end
  end
end
