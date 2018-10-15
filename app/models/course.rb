class Course < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :lessons

  # Validations
  validates :title, presence: true

  def first_lesson
    Lesson.where(course: self, position: 1).first
  end
  
  def total_tickets
    totalReds = 0
    totalBlues = 0
    totalGreens = 0
    if lessons.present?
      lessons.each do |lesson|
        totalReds += lesson.out_red
        totalBlues += lesson.out_blue
        totalGreens += lesson.out_green
      end
    end
    tickets = { red: totalReds, blue: totalBlues, green: totalGreens, total: totalReds + totalBlues + totalGreens }
    tickets
  end
end
