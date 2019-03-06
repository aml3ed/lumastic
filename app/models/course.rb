class Course < ApplicationRecord
  has_one_attached :thumbnail
  belongs_to :user
  belongs_to :community
  has_many :lessons
  include ApplicationHelper

  # Validations
  validates :title, presence: true
  validates :thumbnail, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: "must be JPEG or PNG"}, size: { less_than: 2.megabytes , message: 'must be smaller than 2 MB' }

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

  def get_thumbnail(size=400)
    height = size * 0.5625
    if self.thumbnail.attached? && self.thumbnail.attachment.blob.present? && self.thumbnail.attachment.blob.persisted?
      self.thumbnail.variant(resize: "#{size}x#{height}!")
    else
      "HeaderImage-8.png"
    end
  end

end
