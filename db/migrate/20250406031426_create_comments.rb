class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false
      t.timestamps 

      t.index :post_id  # post_idにインデックスを追加
      t.index :user_id  # user_idにインデックスを追加
    end
  end
end
