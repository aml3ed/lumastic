module ApplicationHelper
  def current_class?(test_path)
    request.path == test_path ? 'active' : ''
  end

  def percent(number, total)
    percent = ((number.to_f / total.to_f) * 100).to_int
    percent
  rescue
    0
  end
end
