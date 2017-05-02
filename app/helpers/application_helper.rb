module ApplicationHelper
  def validation_class(attribute_name)
    if @participant.errors[attribute_name].present?
      return 'form-control error'.html_safe
    else
      return 'form-control'.html_safe
    end
  end
end
