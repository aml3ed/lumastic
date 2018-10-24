class AddUserAndCommunityToMembership < ActiveRecord::Migration[5.2]
  def change
    add_reference :memberships, :user, index: true
    add_reference :memberships, :community, index: true
  end
end
