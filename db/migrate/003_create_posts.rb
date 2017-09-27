class CreatePosts < ActiveRecord::Migration[5.1]
  def self.up
    create_table :posts do |t|
      t.string :username
      t.integer :like_count
      t.integer :comment_count
      t.date :creation_date
      t.string :post_type
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :posts
  end
end
