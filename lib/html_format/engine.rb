module HtmlFormat
  class Engine < Rails::Engine
    initializer 'html_format' do
      ActiveSupport.on_load(:active_record) do
        include HtmlFormat::ActiveRecord

        ::ActiveRecord::Result.class_eval do
          def to_html(**options)
            HtmlFormat.generate(collect(&:to_h), options)
          end
        end
      end

      if defined?(Mongoid::Document)
        Mongoid::Document.include(HtmlFormat::ActiveRecord)
      end
    end
  end
end
