class AddTicketsToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :in_red, :int
    add_column :lessons, :in_blue, :int
    add_column :lessons, :in_green, :int
    add_column :lessons, :out_red, :int
    add_column :lessons, :out_blue, :int
    add_column :lessons, :out_green, :int
  end
end
