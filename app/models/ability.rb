class Ability
  include CanCan::Ability

  def initialize(user)
    # Start with not being able to do anything
    cannot :manage, :all
    user.present? ? initialize_user(user) : grant_guest_roles
  end

  #
  # Set roles for users with an account
  #
  def initialize_user(user)
    can :manage, Discussion
    can :manage, Comment
    case user.role
    when Roleable::ROLE_GUEST
      grant_guest_roles
    when Roleable::ROLE_STUDENT
      grant_student_roles(user)
    when Roleable::ROLE_ADMIN
      grant_admin_roles
    end
  end

  #
  # Set roles for user without an account
  #
  def grant_guest_roles
    can %i[show discussions members courses], Community
    can :show, Discussion
    can :show, Course
    can %i[show count_ticket], Lesson
    can :show, Material
  end

  #
  # Set roles for a student
  #
  def grant_student_roles(user)
    can %i[show index create add_user remove_user members discussions courses], Community

    can %i[show index], Course
    can %i[show index count_ticket], Lesson
    can %i[show index new create], Material

    if user.communities.present?
      grant_community_instance_roles(user)
    end
  end

  #
  # Set roles for a system administrator
  #
  def grant_admin_roles
    can :manage, :all
    can :manage, :admin
  end

  #
  # Set roles for memberships
  #
  def grant_community_instance_roles(user)
    user.communities.each do |community|
      puts '************************** COMMUNITY *****************************'
      can %i[show index new create], Course, community_id: community.id

      # Can create lesson if course is open and user belongs to the community
      can %i[new create], Lesson, course: { type: "OpenCourse", community: community }
      if community.courses.where(user: user).present?
        grant_course_instance_roles(user, community)
      end
    end
  end

  #
  # Set roles for course instances
  #
  def grant_course_instance_roles(user, community)
    community.courses.each do |course|
      # Can manage the course if the user is the course creator
      can :manage, course if course.user == user

      # Can create a lesson if the course is closed and the user is the course creator
      can %i[new create], Lesson, course: { type: "ClosedCourse", user: user }

      grant_lesson_instance_roles(user, course) if course.lessons.present?
    end
  end

  #
  # Set roles for lesson instances
  #
  def grant_lesson_instance_roles(user, course)
    course.lessons.each do |lesson|
      can :manage, lesson if lesson.user == user
      grant_material_instance_roles(lesson) if lesson.materials.present? && lesson.user == user
    end
  end

  #
  # Set roles for material instances
  #
  def grant_material_instance_roles(lesson)
    lesson.materials.each do |mat|
      can :manage, mat
    end
  end
end
