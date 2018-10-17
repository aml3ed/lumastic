class RemoveSubjectFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :subject
  end
end
