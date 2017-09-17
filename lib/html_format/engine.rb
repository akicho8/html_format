module HtmlFormat
  class Engine < Rails::Engine
    initializer "html_format" do
      ActiveSupport.on_load(:active_record) do
        include HtmlFormat::ActiveRecord
      end
    end
  end
end
