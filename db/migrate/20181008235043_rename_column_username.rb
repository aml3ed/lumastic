class RenameColumnUsername < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :username, :display_name
  end
end
