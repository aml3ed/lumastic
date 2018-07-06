class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :course_info
      t.string :subject
      t.string :instructor_bio
      t.string :keywords
      t.boolean :published
      t.float :price

      t.timestamps
    end
  end
end
