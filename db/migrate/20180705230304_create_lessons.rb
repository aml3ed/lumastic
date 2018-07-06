class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :video_url
      t.string :lesson_info
      t.integer :likes
      t.integer :dislikes
      t.integer :shares
      t.boolean :material_access
      t.string :keywords

      t.timestamps
    end
  end
end
