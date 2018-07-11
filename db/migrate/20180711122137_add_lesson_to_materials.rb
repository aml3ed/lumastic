class AddLessonToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_reference :materials, :lesson, foreign_key: true
  end
end
