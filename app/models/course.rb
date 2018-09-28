class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons

  def first_lesson
    Lesson.where(course: self, position: 1).first
  end
end
