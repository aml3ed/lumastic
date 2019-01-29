class Course < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :lessons
  include ApplicationHelper

  # Validations
  validates :title, presence: true

  def first_lesson
    Lesson.where(course: self, position: 1).first
  end

  def default_course
    default_course = Course.new
    default_course.title = "Default Course"
    default_course.course_info = "This is a default course"
    default_course.open = true
    default_course
  end

  def green_percent
    tickets = self.tickets
    if tickets[:total] != 0
      return percent(tickets[:green], tickets[:total]).to_s + "%"
    end
    return "NEW"
  end

  def likes
    likes = 0
    if lessons.present?
      lessons.each do |lesson|
        likes += lesson.likes.to_i
      end
    end
    likes
  end

  def contributors
    contributors = []
    if lessons.present?
      lessons.each do |lesson|
        user = lesson.user.display_name
        unless contributors.include?(user)
          contributors << user
        end
      end
    end
    contributors
  end
  
  def creator
    creator = ""
    if lessons.present?
      first = lessons.order(:created_at).first
      creator = first.author
    end
    creator
  end
  
  def tickets
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
