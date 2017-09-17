require "active_support/core_ext/kernel/concern"

module HtmlFormat
  concern :ActiveRecord do
    class_methods do
      def to_html(**options)
        HtmlFormat.generate(all.collect(&:attributes), options)
      end
    end

    def to_html(**options)
      HtmlFormat.generate(attributes, options)
    end
  end
end

Kernel.class_eval do
  private

  def html_format(*args, &block)
    HtmlFormat.generate(*args, &block)
  end
end

[Array, Symbol, String, Hash, Numeric, TrueClass, FalseClass, NilClass].each do |e|
  e.class_eval do
    def to_html(**options)
      HtmlFormat.generate(self, options)
    end
  end
end
