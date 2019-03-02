class MemberController < ApplicationController
  authorize_resource class: false

  def index
    @courses = Course.left_joins(:lessons).group(:id).order('COUNT(lessons) DESC').limit(4)
    @communities = Community.left_joins(:memberships).group(:id).order('COUNT(memberships) DESC').limit(6)

    @contributedCourses = []
    allUserLessons = current_user.lessons
    allUserLessons.each do |lesson|
      unless contributedCourses.include?(lesson.course)
          @contributedCourses << lesson.course
      end
    end

    @curatedCommunities = []
    allUserCommunities = current_user.communities
    allUserCommunities.each do |community|
        if community.is_user_curator(current_user)
          @curatedCommunities << community
        end
    end
    # @completed = Course.completed_courses
    # @inprogress = Course.inprogress_courses
  end

  def show
  end

end
