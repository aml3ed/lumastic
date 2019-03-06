class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true


  def display_action
    case action
    when Trackable::LOGIN
      "logged in"
    when Trackable::CREATE
      case trackable_type
      when "User"
        "signed up"
      else
        "posted a " + trackable_type
      end
    when Trackable::UPDATE
      "edited a " + trackable_type
    when Trackable::DESTROY
      "deleted a " + trackable_type
    else
      action
    end
  end

  def icon
    # This function is to find what icon the activity uses
    case trackable_type
    # When the activity is login or signup
    when "User"
      case action
      when Trackable::LOGIN
        "heartbeat"
      when Trackable::CREATE
        "user-plus"
      end

    # When the activity is on Comment or Discussion
    when "Comment"
      "comment"
    when "Discussion"
      "comments"

    # When the activity is on Lesson
    when "Lesson"
      "chalkboard-teacher"

    # When the activity is on Course
    when "Course"
      "book"

    # Otherwise
    else
      "heartbeat"
    end
  end
end
