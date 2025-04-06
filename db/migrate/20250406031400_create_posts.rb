class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false 
      t.text :body, null: false 
      t.timestamps 

      t.index :user_id  # user_idにインデックスを追加
    end
  end
end
