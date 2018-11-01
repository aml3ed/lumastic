class AddTypeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :type, :string
  end
end
