class ChangeLessonLikesDislikesDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :lessons, :likes, false, default = 0
    change_column_null :lessons, :dislikes, false, default = 0
  end
end
