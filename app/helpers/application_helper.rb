module ApplicationHelper
  def current_class?(test_path)
    request.path == test_path ? 'active' : ''
  end

  def disabled_if_no_user
    if user_signed_in?
      return ""
    end
    return " disabled"
  end

  def percent(number, total)
    percent = ((number.to_f / total.to_f) * 100).to_int
    percent
  rescue
    0
  end
end
