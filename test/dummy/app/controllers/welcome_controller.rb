class WelcomeController < ApplicationController
  def index
    body = view_context.instance_eval do
      [
        {
          name: "Array Of Hash",
          code: <<~EOT,
[
  {id: 1, name: "alice", created_at: "2000-01-01"},
  {id: 2, name: "bob",   created_at: "2000-01-02"},
  {id: 3, name: "carol", created_at: "2000-01-03"},
].to_html
EOT
        },
        {
          name: "Hash",
          code: %({id: 1, name: "alice", created_at: "2000-01-01"}.to_html),
        },
        {
          name: "Array Of Array",
          code: <<~EOT,
[
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
].to_html
EOT
        },
        {
          name: "Array",
          code: %([1, 2, 3].to_html),
        },
      ].collect { |e|
        out = []
        out << content_tag(:div, content_tag(:h2, e[:name]), class: "page-header")
        out << content_tag(:div, "CODE", class: "label label-info")
        out << content_tag(:pre, e[:code])
        out << content_tag(:div, "OUTPUT", class: "label label-info")
        out << tag(:br)
        out << content_tag(:div, eval(e[:code]), class: "text-center")
      }.join.html_safe
    end

    render html: body, layout: true
  end
end
