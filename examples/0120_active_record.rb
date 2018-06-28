$LOAD_PATH << '../lib'
require 'active_record'
require 'html_format'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base
end

['alice', 'bob', 'carol'].each { |e| User.create!(name: e) }

html_format User                                                            # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr><tr><td>2</td><td>bob</td></tr><tr><td>3</td><td>carol</td></tr></tbody></table></div>"
html_format User.first                                                      # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_hash\"><tr><th>id</th><td>1</td></tr><tr><th>name</th><td>alice</td></tr></table></div>"
html_format User.limit(1)                                                   # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr></tbody></table></div>"
html_format ActiveRecord::Base.connection.select_all('SELECT * FROM users') # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr><tr><td>2</td><td>bob</td></tr><tr><td>3</td><td>carol</td></tr></tbody></table></div>"

User.to_html                                                                # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr><tr><td>2</td><td>bob</td></tr><tr><td>3</td><td>carol</td></tr></tbody></table></div>"
User.first.to_html                                                          # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_hash\"><tr><th>id</th><td>1</td></tr><tr><th>name</th><td>alice</td></tr></table></div>"
User.limit(1).to_html                                                       # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr></tbody></table></div>"
ActiveRecord::Base.connection.select_all('SELECT * FROM users').to_html     # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>id</th><th>name</th></tr></thead><tbody><tr><td>1</td><td>alice</td></tr><tr><td>2</td><td>bob</td></tr><tr><td>3</td><td>carol</td></tr></tbody></table></div>"
