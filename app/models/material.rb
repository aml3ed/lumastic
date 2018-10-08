class Material < ApplicationRecord
  belongs_to :lesson, inverse_of: :materials
  has_one_attached :file
end
