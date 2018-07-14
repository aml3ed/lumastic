class Lesson < ApplicationRecord
  belongs_to :course
  has_many :materials, inverse_of: :lesson
  accepts_nested_attributes_for :materials, allow_destroy: true
end
