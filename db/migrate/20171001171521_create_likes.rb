class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :thought_id
      t.integer :liked_id

      t.timestamps
    end
    add_index :likes, :thought_id
    add_index :likes, :liked_id
    add_index :likes, [:thought_id, :liked_id], unique: true
  end
end
