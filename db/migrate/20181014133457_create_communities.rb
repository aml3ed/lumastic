class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    create_join_table :communities, :users do |t|
      t.index [:community_id, :user_id]
    end
  end
end
