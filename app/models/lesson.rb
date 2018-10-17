class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :materials, inverse_of: :lesson, dependent: :delete_all
  accepts_nested_attributes_for :materials, allow_destroy: true

  # Validations
  validates :title, presence: true
  validates :video_url, presence: true, uniqueness: false
  validates :position, presence: true, uniqueness: { scope: :course }
  end
