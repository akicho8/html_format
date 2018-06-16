$LOAD_PATH << '../lib'
require 'active_record'
require 'mongoid'
require 'html_format'

Mongo::Logger.logger.level = Logger::INFO
Mongoid::Config.connect_to('test')
Mongoid::Clients.default.database.drop

class User
  include Mongoid::Document
  field :name, type: String
end

['alice', 'bob', 'carol'].each { |e| User.create!(name: e) }

html_format User                # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>5b24bdcdf6453f3018f7a79e</td><td>alice</td></tr><tr><td>5b24bdcdf6453f3018f7a79f</td><td>bob</td></tr><tr><td>5b24bdcdf6453f3018f7a7a0</td><td>carol</td></tr></tbody></table></div>"
html_format User.first          # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_hash\"><tr><th>_id</th><td>5b24bdcdf6453f3018f7a79e</td></tr><tr><th>name</th><td>alice</td></tr></table></div>"
html_format User.limit(1)       # => "<div class=\"html_format html_format_depth_0\"><table class=\"table table-striped table-bordered table-hover html_format_type_array_of_hash\"><thead><tr><th>_id</th><th>name</th></tr></thead><tbody><tr><td>5b24bdcdf6453f3018f7a79e</td><td>alice</td></tr></tbody></table></div>"
