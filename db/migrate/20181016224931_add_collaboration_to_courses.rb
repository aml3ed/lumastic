class AddCollaborationToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :open, :boolean
  end
end
