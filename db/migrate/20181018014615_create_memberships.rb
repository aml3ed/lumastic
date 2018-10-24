class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships, :id => false do |t|
      t.string :role
      t.timestamps
    end
  end
end
