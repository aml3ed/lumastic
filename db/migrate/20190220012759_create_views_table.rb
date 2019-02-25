class CreateViewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :views, :id => false do |t|
      t.integer :lesson_count
      t.timestampst
    end
    add_reference :views, :user, index:true
    add_reference :views, :lesson, index:true
  end
end
