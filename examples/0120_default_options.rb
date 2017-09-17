$LOAD_PATH << '../lib'
require 'html_format'

p HtmlFormat.default_options
# >> {:table_class=>"", :nesting=>false, :title_tag=>:h2, :header_patch=>false, :key_label=>"Key", :value_label=>"Value"}
