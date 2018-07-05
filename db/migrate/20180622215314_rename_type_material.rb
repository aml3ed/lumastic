class RenameTypeMaterial < ActiveRecord::Migration[5.2]
  def change
  	rename_column :materials, :type, :category
  end
end
