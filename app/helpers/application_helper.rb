module ApplicationHelper
  def active_class?(current_path)
    "active" if current_page?(current_path)
  end
end
