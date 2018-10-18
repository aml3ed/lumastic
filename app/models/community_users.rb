class CommunityUsers < ApplicationRecord
  # Relationships
  belongs_to :community
  belongs_to :user
end
