class CreateCommunityUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :community_users, id: false do |t|
      t.string :role, default: CommunityRoles::ROLE_NONE
      t.index [:community_id, :user_id]
    end
  end
end
