require 'active_support/core_ext/module'
require 'active_support/core_ext/string'
require 'action_view'

module HtmlFormat
  mattr_accessor :default_options
  self.default_options = {
    table_class: ['table', 'table-striped', 'table-bordered', 'table-hover'],
    sub_table_class: ['table', 'table-condensed'],
    nesting: false,
    title_tag: :h2,
    header_patch: false,     # If there is no header, add it
    key_label: 'Key',
    value_label: 'Value',
  }

  def self.generate(*args, &block)
    Generator.generate(*args, &block)
  end

  class Generator
    include ActionView::Helpers::TagHelper

    attr_accessor :output_buffer

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

      if v = @options[:caption].presence
        body << v
      end
      if @options[:header_patch]
        if info[:header_process]
          if v = info[:header_process].call(obj)
            body << v
          end
        end
      end
      body << info[:process].call(obj)
      body = tag.table(body, :class => table_class(info))
      if @options[:depth].zero?
        if @options[:responsive]
          body = tag.div(body, :class => 'table-responsive')
        end
        if @options[:title].present?
          body = tag.send(@options[:title_tag], @options[:title], :class => 'title') + body
        end
      end
      tag.div(body, :class => ['html_format', "html_format_depth_#{@options[:depth]}"])
    end

    private

    def function_table
      [
        # Hash
        #
        # {a: 1, b: 2}
        #
        # [a][1]
        # [b][2]
        {
          _case: -> e { e.kind_of?(Hash) },
          css_class: 'html_format_type_hash',
          header_process: -> e {
            tag.thead do
              tag.tr do
                tag.th(@options[:key_label]) + tag.th(@options[:value_label])
              end
            end
          },
          process: -> e {
            e.collect {|key, val|
              tag.tr do
                tag.th(key) + td(val)
              end
            }.join.html_safe
          },
        },

        # Array of Hash
        #
        # [{a: 1, b: 2}, {a: 3, b: 4}]
        #
        # [a][b]
        # [1][2]
        # [3][4]
        {
          _case: -> e { e.kind_of?(Array) && e.all?{|e|e.kind_of?(Hash)} },
          css_class: 'html_format_type_array_of_hash',
          process: -> e {
            keys = e.inject([]) { |a, e| a | e.keys }
            body = ''.html_safe
            body += tag.thead do
              tag.tr do
                keys.collect {|e| tag.th(e) }.join.html_safe
              end
            end
            body + tag.tbody do
              e.collect { |hash|
                tag.tr do
                  keys.collect { |key| td(hash[key]) }.join.html_safe
                end
              }.join.html_safe
            end
          },
        },

        # Array of Array
        #
        # [[:a, :b], [ 1,  2], [ 3,  4]]
        #
        # [a][b]
        # [1][2]
        # [3][4]
        {
          _case: -> e { e.kind_of?(Array) && e.all?{|e|e.kind_of?(Array)} },
          css_class: 'html_format_type_array_of_array',
          header_process: -> e {
            if e.first.kind_of?(Array)
              tag.thead do
                # I do not know the meaning of the column so make it empty label
                e.first.collect { td('') }.join.html_safe
              end
            end
          },
          process: -> e {
            tag.tbody do
              e.collect { |elems|
                tag.tr do
                  elems.collect { |e| td(e) }.join.html_safe
                end
              }.join.html_safe
            end
          },
        },

        # Array
        #
        # [:a, :b]
        #
        # [a][b]
        {
          _case: -> e { e.kind_of?(Array) },
          css_class: 'html_format_type_array',
          process: -> e {
            tag.tbody do
              tag.tr do
                e.collect { |e| td(e) }.join.html_safe
              end
            end
          },
        },

        # Ohter
        #
        # :a
        #
        # [a]
        {
          _case: -> e { true },
          css_class: 'html_format_type_object',
          process: -> e {
            tag.tbody do
              tag.tr { td(e) }
            end
          },
        },
      ]
    end

    def td(val)
      tag.td(value_as_string(val))
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
        [@options[:table_class], info[:css_class]].join(' ').squish.scan(/\S+/).uniq.join(' ')
      else
        # Keep nested tables small and avoid decorations
        @options[:sub_table_class]
      end
    end
  end
end
