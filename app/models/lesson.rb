class Lesson < ApplicationRecord
  has_many :activities, as: :trackable
  belongs_to :course
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :materials, inverse_of: :lesson, dependent: :delete_all
  has_many :views
  accepts_nested_attributes_for :materials, allow_destroy: true

  # Validations
  validates :title, presence: true
  validates :video_url, presence: true, uniqueness: false, format: {with: /\A(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+\z/}
  validates :position, presence: true, uniqueness: { scope: :course }

  include LessonsHelper

  def votes_difference
    likes = self.likes
    dislikes = self.dislikes
    difference = likes - dislikes
    difference
  end

  def author
    author = ""
    unless self.user.nil?
      author = self.user.display_name
    end
    author
  end

  def next
    course = self.course
    position = self.position
    if course.lessons.size > position
      return course.lessons.where("position > ?", position).first
    end
    return nil
  end

  def previous
    course = self.course
    position = self.position
    if position <= course.lessons.size
      return course.lessons.where("position < ?", position).last
    end
    return nil
  end

  def duration
    vid_id = youtube_id(self.video_url)
    unless vid_id.blank?
      video = Yt::Video.new id: vid_id
      return video.duration
    else
      return 0
    end
  end

  def display_duration
    duration = self.duration
    minutes = (duration / 60) % 60
    hours = duration / (3600)
    if minutes < 1
      return "1m"
    elsif hours < 1
      return format("%dm", minutes)
    else
      return format("%dh%dm", hours, minutes)
    end
  end
end
