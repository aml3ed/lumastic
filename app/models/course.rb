class Course < ApplicationRecord
  # Relationships
  has_many :users
  belongs_to :community
  has_many :lessons

  # Constants
  TYPE_OPEN = 'open'.freeze unless defined? TYPE_OPEN
  TYPE_CLOSED = 'closed'.freeze unless defined? TYPE_CLOSED
  ALL_TYPES = [TYPE_OPEN, TYPE_CLOSED].freeze unless defined? ALL_TYPES

  # Validations
  validates :title, presence: true

  def first_lesson
    Lesson.where(course: self, position: 1).first
  end

  def default_course
    default_course = Course.new
    default_course.title = "Default Course"
    default_course.course_info = "This is a default course"
    default_course.type = TYPE_OPEN
    default_course
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
