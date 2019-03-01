class MemberController < ApplicationController

  def index
    @courses = Course.all
    @communities = Community.all

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
