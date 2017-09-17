$LOAD_PATH << '../lib'
require 'active_record'
require 'mongoid' # !> method redefined; discarding old as_json
require 'html_format'

Mongo::Logger.logger.level = Logger::INFO
Mongoid::Config.connect_to('test')
Mongoid::Clients.default.database.drop

class User
  include Mongoid::Document
  field :name, type: String
end

['alice', 'bob', 'carol'].each { |e| User.create!(name: e) } # !> method redefined; discarding old text_search

html_format User                # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_hash table-striped table-bordered table-hover\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>59bb41ebf6453f7a6e96d5df</td><td>alice</td></tr><tr><td>59bb41ecf6453f7a6e96d5e0</td><td>bob</td></tr><tr><td>59bb41ecf6453f7a6e96d5e1</td><td>carol</td></tr></tbody></table></div>"
html_format User.first          # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_hash table-striped table-bordered table-hover\"><tr><th>_id</th><td>59bb41ebf6453f7a6e96d5df</td></tr><tr><th>name</th><td>alice</td></tr></table></div>"
html_format User.limit(1)       # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_hash table-striped table-bordered table-hover\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>59bb41ebf6453f7a6e96d5df</td><td>alice</td></tr></tbody></table></div>"
