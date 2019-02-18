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


  def likes
    likes = 0
    if lessons.present?
      lessons.each do |lesson|
        likes += lesson.likes.to_i
      end
    end
    likes
  end

  def duration
    time = 0
    if lessons.present?
      lessons.each do |lesson|
        time += lesson.duration
      end
    end
    time
  end

  def display_duration
    duration = self.duration
    minutes = (duration / 60) % 60
    hours = duration / (3600)
    if hours < 1
      return format("%dm", minutes)
    else
      return format("%dh%dm", hours, minutes)
    end
  end

  def contributors
    contributors = []
    if lessons.present?
      lessons.each do |lesson|
        contributor = lesson.user
        unless contributors.include?(contributor)
          contributors << contributor
        end
      end
    end
    {:count => contributors.count, :users => contributors}
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
