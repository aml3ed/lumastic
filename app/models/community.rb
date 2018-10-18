class Community < ApplicationRecord
  # Relationships
  has_many :users, through: :community_users
  has_many :courses
end
