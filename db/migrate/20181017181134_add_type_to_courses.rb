class AddTypeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :type, :string, default: Course::TYPE_OPEN
  end
end
