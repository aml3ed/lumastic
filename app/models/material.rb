class Material < ApplicationRecord
  belongs_to :lesson, inverse_of: :materials
end
