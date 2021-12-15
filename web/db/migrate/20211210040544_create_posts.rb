class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
