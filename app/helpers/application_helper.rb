module ApplicationHelper
  def controller_css_class
    controller_path.parameterize.dasherize + "-controller"
  end
end
