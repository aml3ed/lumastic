class AddDiscussionModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :discussions, :user, index: true
  end
end
