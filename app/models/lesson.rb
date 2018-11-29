class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :materials, inverse_of: :lesson, dependent: :delete_all
  accepts_nested_attributes_for :materials, allow_destroy: true

  # Validations
  validates :title, presence: true
  validates :video_url, presence: true, uniqueness: false, format: {with: /\A(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+\z/}
  validates :position, presence: true, uniqueness: { scope: :course }

  def votes_difference
    likes = self.likes
    dislikes = self.dislikes
    difference = likes - dislikes
    difference
  end
end
