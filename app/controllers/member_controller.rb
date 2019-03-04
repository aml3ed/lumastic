class MemberController < ApplicationController
  authorize_resource class: false

  def index
    # Get courses with most lessons
    @courses = Course.left_joins(:lessons).group(:id).order('COUNT(lessons) DESC').limit(4)

    # Get communities with most members
    @communities = Community.left_joins(:memberships).group(:id).order('COUNT(memberships) DESC').limit(6)

    # Get discussion in communities, order by most comments, take first 5
    @discussions = @communities.to_a.collect{|d| d.discussions.to_a}.flatten()
    @discussions = @discussions.sort_by!{|d| d.comments.count}.take(5)

    # Get courses user has contributed to
    @contributedCourses = []
    allUserLessons = current_user.lessons
    allUserLessons.each do |lesson|
      unless contributedCourses.include?(lesson.course)
          @contributedCourses << lesson.course
      end
    end

    # Get communities user is curator of
    @curatedCommunities = []
    allUserCommunities = current_user.communities
    allUserCommunities.each do |community|
        if community.is_user_curator(current_user)
          @curatedCommunities << community
        end
    end

    # Get courses user has completed and are in progress
    @completedCourses = []
    @inprogressCourses = []
    viewedLessonCount = 0
    lessonCount = 0
    allCourses = @courses
    allCourses.each do |course|
      course.lessons.each do |lesson|
        lessonCount = lessonCount + 1
        lesson.views.each do |view|
          if view.user == current_user
            viewedLessonCount = viewedLessonCount + 1
          end
        end
      end
      if (lessonCount == viewedLessonCount)
        @completedCourses << course
      end
      if (viewedLessonCount >= 1 && viewedLessonCount < lessonCount)
        @inprogressCourses << course
      end
    end

  end

  def show
  end

end
