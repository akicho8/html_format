class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # helper :html_format
  # include HtmlFormatHelper
  # helper HtmlFormat::Application.helpers

  # helper HtmlFormat::HtmlFormatHelper
  # helper HtmlFormat::Engine.helpers
end
