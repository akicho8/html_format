module HtmlFormat
  mattr_accessor :default_options
  self.default_options = {
    table_class: '',
    nesting: false,
    title_tag: :h2,

    header_patch: false,     # ヘッダーがなければ追加する
    key_label: 'Key',
    value_label: 'Value',
  }

  def self.generate(*args, &block)
    Base.generate(*args, &block)
  end

  class Base
    def self.generate(*args, &block)
      if block_given?
        object = yield
        options = args.extract_options!
      else
        if args.size == 0
          return
        elsif args.size == 1
          object = args.first
          options = {}
        else
          options = args.extract_options!
          if args.size > 1
            object = args
          else
            object = args.first
          end
        end
      end

      new(options).generate(object)
    end

    def initialize(options)
      @options = HtmlFormat.default_options.merge(depth: 0).merge(options)
    end

    def generate(obj)
      return if obj.blank?

      info = function_table.find { |e| e[:_case].call(obj) }
      body = ''.html_safe
      if true
        if @options[:caption].present?
          body << content_tag(:caption, @options[:caption])
        end
      end
      if @options[:header_patch]
        if info[:header_patch]
          if v = info[:header_patch].call(obj)
            body << v
          end
        end
      end
      body << info[:process].call(obj)
      body = content_tag(:table, body, :class => table_class(info))
      if @options[:depth].zero?
        if @options[:responsive]
          body = content_tag(:div, body, :class => 'table-responsive')
        end
        if @options[:title].present?
          body = content_tag(@options[:title_tag], @options[:title], :class => 'title') + body
        end
      end
      content_tag(:div, body, :class => "html_format html_format_depth_#{@options[:depth]}")
    end

    private

    def function_table
      [
        # {a: 1, b: 2}
        # [a][1]
        # [b][2]
        {
          _case: -> e { e.kind_of?(Hash) },
          css_class: 'qt_type_hash',
          header_patch: -> e {
            content_tag(:thead) do
              tr do
                th(@options[:key_label]) + th(@options[:value_label])
              end
            end
          },
          process: -> e {
            e.collect {|key, val|
              tr do
                th(key) + td(val)
              end
            }.join.html_safe
          },
        },

        # [{a: 1, b: 2}, {a: 3, b: 4}]
        # [a][b]
        # [1][2]
        # [3][4]
        {
          _case: -> e { e.kind_of?(Array) && e.all?{|e|e.kind_of?(Hash)} },
          css_class: 'qt_type_array_of_hash',
          process: -> e {
            keys = e.inject([]) { |a, e| a | e.keys }
            body = ''.html_safe
            body += content_tag(:thead) do
              tr do
                keys.collect {|e| th(e) }.join.html_safe
              end
            end
            body + content_tag(:tbody) do
              e.collect { |hash|
                tr do
                  keys.collect { |key| td(hash[key]) }.join.html_safe
                end
              }.join.html_safe
            end
          },
        },

        # [[:a, :b], [ 1,  2], [ 3,  4]]
        # [a][b]
        # [1][2]
        # [3][4]
        {
          _case: -> e { e.kind_of?(Array) && e.all?{|e|e.kind_of?(Array)} },
          css_class: 'qt_type_array_of_array',
          header_patch: -> e {
            if e.first.kind_of?(Array)
              content_tag(:thead) do
                e.first.collect { td('') }.join.html_safe # カラムの意味はわからないので空ラベルとする
              end
            end
          },
          process: -> e {
            content_tag(:tbody) do
              e.collect { |elems|
                tr do
                  elems.collect { |e| td(e) }.join.html_safe
                end
              }.join.html_safe
            end
          },
        },

        # [:a, :b]
        # [a][b]
        {
          _case: -> e { e.kind_of?(Array) },
          css_class: 'qt_type_array',
          process: -> e {
            content_tag(:tbody) do
              tr do
                e.collect { |e| td(e) }.join.html_safe
              end
            end
          },
        },

        # :a
        # [a]
        {
          _case: -> e { true },
          css_class: 'qt_type_object',
          process: -> e {
            content_tag(:tbody) do
              tr { td(e) }
            end
          },
        },
      ]
    end

    def h
      ApplicationController.helpers
    end

    def content_tag(*args, &block)
      h.content_tag(*args, &block)
    end

    def tr(&block)
      content_tag(:tr, &block)
    end

    def th(val)
      content_tag(:th, val)
    end

    def td(val)
      content_tag(:td, value_as_string(val))
    end

    def value_as_string(val)
      if val.kind_of?(Array) || val.kind_of?(Hash)
        if @options[:nesting]
          self.class.generate(@options.merge(depth: @options[:depth].next)) { val }
        else
          val
        end
      else
        val
      end
    end

    def table_class(info)
      if @options[:depth] == 0
        # return 'table table-condensed table-bordered table-striped'
        "table #{info[:css_class]} #{@options[:table_class]}".squish.scan(/\S+/).uniq.join(' ')
      else
        # 入れ子になったテーブルは小さめにして装飾を避ける
        'table table-condensed'
      end
    end
  end
end
