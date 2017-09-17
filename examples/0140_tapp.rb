$LOAD_PATH << '../lib'
require 'tapp'
require 'html_format'

"Hello".reverse.tapp(:html_format).reverse.tapp
# >> <div class="html_format html_format_depth_0"><table class="table html_format_type_object table-striped table-bordered table-hover"><tbody><tr><td>olleH</td></tr></tbody></table></div>
# >> "Hello"
