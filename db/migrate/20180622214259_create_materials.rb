class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :type
      t.string :title
      t.string :file_url

      t.timestamps
    end
  end
end
