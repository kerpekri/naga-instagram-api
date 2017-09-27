class AddInstagramPostId < ActiveRecord::Migration[5.1]
  def self.up
    add_column(:posts, :instagram_post_id, :integer)
  end

  def self.down
    remove_column(:posts, :instagram_post_id)
  end
end
