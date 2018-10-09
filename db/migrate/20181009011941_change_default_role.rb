class ChangeDefaultRole < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :role, 'student')
  end
end
