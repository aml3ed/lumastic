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
      grant_student_roles
    when Roleable::ROLE_TEACHER
      grant_teacher_roles
    when Roleable::ROLE_ADMIN
      grant_admin_roles
    end
  end

  #
  # Set roles for user without an account
  #
  def grant_guest_roles
    can :manage, :all
  end

  #
  # Set roles for a student
  #
  def grant_student_roles
    can :manage, :all
  end

  #
  # Set roles for a teacher
  #
  def grant_teacher_roles
    can :manage, :all
  end

  #
  # Set roles for a system administrator
  #
  def grant_admin_roles
    can :manage, :all
  end

end
