class AddLessonToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :lesson, index: true
  end
end
