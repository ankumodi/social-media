class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :tags
      t.integer :likes
      t.integer :dislikes
      t.integer :views
      t.timestamps
    end
  end
end
