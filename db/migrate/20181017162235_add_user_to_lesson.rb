class AddUserToLesson < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :user, index: true
  end
end
