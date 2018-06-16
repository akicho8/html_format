$LOAD_PATH << '../lib'
require 'html_format'

html_format(nil)                # => nil
html_format(1) # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>"
1.to_html      # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_object\"><tbody><tr><td>1</td></tr></tbody></table></div>"
[].to_html     # => nil
"".to_html     # => nil

v = [
  {id: 1, name: "alice", created_at: "2000-01-01"},
  {id: 2, name: "bob",   created_at: "2000-01-02"},
  {id: 3, name: "carol", created_at: "2000-01-03"},
]
v.to_html # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th><th>created_at</th></tr></thead><tbody><tr><td>1</td><td>alice</td><td>2000-01-01</td></tr><tr><td>2</td><td>bob</td><td>2000-01-02</td></tr><tr><td>3</td><td>carol</td><td>2000-01-03</td></tr></tbody></table></div>"

v = {id: 1, name: "alice", created_at: "2000-01-01"}
v.to_html # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_hash\"><tr><th>id</th><td>1</td></tr><tr><th>name</th><td>alice</td></tr><tr><th>created_at</th><td>2000-01-01</td></tr></table></div>"

v = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
]
v.to_html # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_array\"><tbody><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>4</td><td>5</td><td>6</td></tr><tr><td>7</td><td>8</td><td>9</td></tr></tbody></table></div>"

[0, 1, 2, 3].to_html # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array\"><tbody><tr><td>0</td><td>1</td><td>2</td><td>3</td></tr></tbody></table></div>"

