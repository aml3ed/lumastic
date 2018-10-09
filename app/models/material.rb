class Material < ApplicationRecord
  belongs_to :lesson, inverse_of: :materials
  has_one_attached :file

  validates :title, presence: true
  validates :file_url, presence: true
end
