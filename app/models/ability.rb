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
    can :show, Course
    can %i[show count_ticket], Lesson
    can :show, Material
  end

  #
  # Set roles for a student
  #
  def grant_student_roles(user)
    can :show, Course
    can %i[show count_ticket], Lesson
    can :show, Material
    can %i[new create], Community

    if user.communities.present?
      grant_community_instance_roles(user.communities)
    end
  end

  #
  # Set roles for a system administrator
  #
  def grant_admin_roles
    can :manage, :all
  end

  #
  # Set roles for Community instances
  #
  def grant_community_instance_roles(communities)
    communities.each do |community|
      # case community
      can %i[show index], community

    end
  end

  #
  # Set roles for course instances
  #
  def grant_course_instance_roles(course_instances)
    course_instances.each do |course|
      can :manage, course
      grant_lesson_instance_roles(course) if course.lessons.present?
    end
  end

  #
  # Set roles for lesson instances
  #
  def grant_lesson_instance_roles(course)
    course.lessons.each do |lesson|
      can :manage, lesson
      grant_material_instance_roles(lesson) if lesson.materials.present?
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
