class WelcomeController < ApplicationController
  def index
    body = view_context.instance_eval do
      [
        {
          :name => "Array Of Hash",
          :code => <<~EOT,
[
  {id: 1, name: "alice", created_at: "2000-01-01"},
  {id: 2, name: "bob",   created_at: "2000-01-02"},
  {id: 3, name: "carol", created_at: "2000-01-03"},
].to_html
EOT
        },
        {
          :name => "Hash",
          :code => %({id: 1, name: "alice", created_at: "2000-01-01"}.to_html),
        },
        {
          :name => "Array Of Array",
          :code => <<~EOT,
[
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
].to_html
EOT
        },
        {
          :name => "Array",
          :code => %([1, 2, 3].to_html),
        },
      ].collect { |e|
        out = []
        out << content_tag(:div, content_tag(:h2, e[:name]), :class => "page-header")
        out << content_tag(:div, "CODE", :class => "label label-info")
        out << content_tag(:pre, e[:code])
        out << content_tag(:div, "OUTPUT", :class => "label label-success")
        out << tag(:br)
        out << tag(:br)
        out << eval(e[:code])
      }.join
    end

    # #
    # # / = data.to_html(title: "Array of Hash")
    # # / = data.first.values.to_html(title: "Array")
    # # / = [[:id, :name, :created_at], *data.collect(&:values)].to_html(title: "Array of Array")
    # #
    # # / = :a.to_html(title: :a)
    # # / {:a => 1, :b => 1} } %>
    # # / [{:a => 1, :b => 2}, {:a => 3, :b => 4}] } %>
    # # / [[:a, :b], [ 1,  2], [ 3,  4]] } %>
    # # / [:a, :b] } %>
    # # / :a } %>
    # #
    # #
    # # / <%- long = "あ(%)" * 20 %>
    # # / <%- long2 = "あ(%)" * 10 %>
    # # /
    # # / <%#= html_format(options) { [{"項目" => :id, "値" => [{:a => 1, :b => 2}, {:a => 1, :b => 2}]}]  } %>
    # # / <%#= html_format(options) { {:a => 1, :b => 1} } %>
    # # / <%#= html_format(options) { [[:a, :b], [ 1,  2], [ 3,  4]] } %>
    # # / <%#= {:a => 1, :b => 2}.to_html %>
    # # / <%= [{long => long2}, {long => long2}, {long => long2}, {long => long2}].to_html %>
    # # / <%#= nil.to_html %>
    # # /
    # # / <% if true %>
    # # /   <%= html_format(options) {} %>
    # # /   <%= html_format(options) { :a } %>
    # # /   <%= html_format(options) { {:a => 1, :b => 1} } %>
    # # /   <%= html_format(options) { [{:a => 1, :b => 2}, {:a => 3, :b => 4}] } %>
    # # /   <%= html_format(options) { [[:a, :b], [ 1,  2], [ 3,  4]] } %>
    # # /   <%= html_format(options) { [:a, :b] } %>
    # # /   <%= html_format(options) { :a } %>
    # # /
    # # /   <%= html_format(options.merge(:responsive => true, :title => "title")) { "あ" * 100 } %>
    # # /   <%= html_format(options.merge(:responsive => true, :caption => "caption")) { "あ" * 100 } %>
    # # /
    # # /   <% v1 = [{:a => 1, :b => 2}, {:a => 3, :b => 4}] %>
    # # /   <%= html_format(options) { [{:a => v1}] } %>
    # # / <% end %>

    render inline: body, layout: true
  end
end
