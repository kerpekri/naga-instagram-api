class AddLinkToPostToPosts < ActiveRecord::Migration[5.1]
  def self.up
    add_column(:posts, :link_to_post, :string)
  end

  def self.down
    remove_column(:posts, :link_to_post)
  end
end
