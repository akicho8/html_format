$LOAD_PATH << '../lib'
require 'html_format'

html_format { 1 }               # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>"
html_format(title: "foo") { 1 } # => "<div class=\"html_format html_format_depth_0\"><h2 class=\"title\">foo</h2><table class=\"table table-striped table-bordered table-hover html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>"
