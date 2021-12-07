module ApplicationHelper
  def home_page?
    controller_name == 'home' && action_name == 'index'
  end
end
