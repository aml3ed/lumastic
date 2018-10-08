class AddTicketsToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :in_red, :int, default: 0
    add_column :lessons, :in_blue, :int, default: 0
    add_column :lessons, :in_green, :int, default: 0
    add_column :lessons, :out_red, :int, default: 0
    add_column :lessons, :out_blue, :int, default: 0
    add_column :lessons, :out_green, :int, default: 0
  end
end
