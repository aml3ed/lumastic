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
