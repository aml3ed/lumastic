class AddCourseidToLessons < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :course, index: true
  end
end
