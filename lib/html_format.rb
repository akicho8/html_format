require "html_format/generator"
require "html_format/core_ext"
require "html_format/version"

if defined?(Rails::Engine)
  require 'html_format/engine'
else
  if defined?(ActiveSupport)
    ActiveSupport.on_load(:active_record) do
      include HtmlFormat::ActiveRecord

      ActiveRecord::Result.class_eval do
        def to_html(**options)
          HtmlFormat.generate(collect(&:to_h), options)
        end
      end
    end
  end
  if defined?(Mongoid::Document)
    Mongoid::Document.include(HtmlFormat::ActiveRecord)
  end
end
