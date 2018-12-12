class DefaultLikesDislikes < ActiveRecord::Migration[5.2]
  def change
    change_column :lessons, :likes, :integer, default: 1
    change_column :lessons, :dislikes, :integer, default: 0
  end
end
