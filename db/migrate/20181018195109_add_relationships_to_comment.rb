class AddRelationshipsToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :discussion, index: true
    add_reference :comments, :parent, index: true
  end
end
