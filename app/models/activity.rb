class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true


  def display_action
    case action
    when Trackable::LOGIN
      "logged in"
    when Trackable::CREATE
      "posted a"
    when Trackable::UPDATE
      "edited a"
    when Trackable::DESTROY
      "deleted a"
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

    # When the activity is on Lesson
    when "Comment" || "Discussion"
      "posted a"

    # When the activity is on Course
    when "Lesson"
      "edited a"

    # When the activity is on Community
    when "Course"
      "deleted a"

    # Otherwise
    else
      "heartbeat"
    end
  end
end
