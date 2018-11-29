class AddUpvoteDownvoteToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :upvote, :int, default: 1
    add_column :comments, :downvote, :int, default: 0
  end
end
