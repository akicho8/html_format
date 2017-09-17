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

html_format User                # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_hash\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>59b24e56f6453f478bec5d79</td><td>alice</td></tr><tr><td>59b24e56f6453f478bec5d7a</td><td>bob</td></tr><tr><td>59b24e56f6453f478bec5d7b</td><td>carol</td></tr></tbody></table></div>"
html_format User.first          # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_hash\"><tr><th>_id</th><td>59b24e56f6453f478bec5d79</td></tr><tr><th>name</th><td>alice</td></tr></table></div>"
html_format User.limit(1)       # => "<div class=\"html_format html_format_depth_0\"><table class=\"table html_format_type_array_of_hash\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>59b24e56f6453f478bec5d79</td><td>alice</td></tr></tbody></table></div>"
