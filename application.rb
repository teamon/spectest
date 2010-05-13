class Spectest < Merb::Controller

  # Templates go in: views/index.html.erb
  # Layouts go in: views/layout.application.html.erb
  # Modify this method to use another location.
  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def index
    "Yo"
  end

  def foo
    render
  end
  
end