class AddCoursesToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :community, index: true
  end
end
