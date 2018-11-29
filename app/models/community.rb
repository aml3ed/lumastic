class Community < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :discussions
  has_many :courses

  #
  # Return a list of open courses for a community
  #
  def open_courses
    courses.where(type: "OpenCourse")
  end

  #
  # Return a list of closed courses for a community
  #
  def closed_courses
    courses.where(type: "ClosedCourse")
  end

  def is_user_member(current_user)
    if current_user
      return self.users.include?(current_user)
    end
    return false
  end

  def last_updated
    community_updated = self.updated_at
    course_updated = self.courses.maximum(:updated_at)
    [community_updated, course_updated].max
  end
    
  def is_user_curator(current_user)
    if current_user
      return self.memberships.find_by(user_id: current_user.id).role == "Curator"
    end
    return false
  end

end
