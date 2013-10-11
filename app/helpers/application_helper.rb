module ApplicationHelper
  def show_nice_errors(model_name)
    errors = ''
    if model_name.errors.any?
      errors << "<div class=\"errors bs-callout bs-callout-danger\">"
        errors << "<h4><i class=\"icon-warning-sign\"></i> Please check the fields below:</h4>"
        errors << "<ul>"
        model_name.errors.full_messages.each do |msg|
          errors << "<li>#{msg}</li>"
        end
        errors << "</ul>"
      errors << "</div>"
    end
    errors.html_safe
  end
end
