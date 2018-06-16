$LOAD_PATH << '../lib'
require 'html_format'

HtmlFormat.default_options      # => {:table_class=>["table", "table-striped", "table-bordered", "table-hover"], :nesting=>false, :title_tag=>:h2, :header_patch=>false, :key_label=>"Key", :value_label=>"Value"}
