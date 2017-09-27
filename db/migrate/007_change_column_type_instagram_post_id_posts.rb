class ChangeColumnTypeInstagramPostIdPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_column :posts, :instagram_post_id, :string
  end

  def self.down
  end
end
