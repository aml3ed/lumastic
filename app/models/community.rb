class Community < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :discussions
  has_many :courses

  #
  # Return a list of open courses for a community
  #
  def open_courses
    courses.where(type: "Open")
  end

  #
  # Return a list of closed courses for a community
  #
  def closed_courses
    courses.where(type: "Closed")
  end
end
