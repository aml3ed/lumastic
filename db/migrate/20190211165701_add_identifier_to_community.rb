class AddIdentifierToCommunity < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :identifier, :string
  end
end
