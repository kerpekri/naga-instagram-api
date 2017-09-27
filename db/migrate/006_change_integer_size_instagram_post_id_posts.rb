class ChangeIntegerSizeInstagramPostIdPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_column :posts, :instagram_post_id, :integer, limit: 8
  end

  def self.down
    change_column :posts, :instagram_post_id, :integer, limit: 4
  end
end
