class AddCommunityToDiscussion < ActiveRecord::Migration[5.2]
  def change
    add_reference :discussions, :community, index: true
  end
end
