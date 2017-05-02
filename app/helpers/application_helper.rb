module ApplicationHelper
  def validation_class(attribute_name)
    if @participant.errors[attribute_name].present?
      return 'error'.html_safe
    else
      return ''.html_safe
    end
  end

  def admin?
    session[:admin]
  end

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      if (username == 'admin' && password == 'secret')
        session[:admin] = true
      end
    end
  end
end
