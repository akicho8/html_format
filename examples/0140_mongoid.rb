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

html_format User          # => 
html_format User.first    # => 
html_format User.limit(1) # => 

User.to_html              # => 
User.first.to_html        # => 
User.limit(1).to_html     # => 
# ~> <internal:/usr/local/var/rbenv/versions/3.2.1/lib/ruby/site_ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:148:in `require': cannot load such file -- mongoid (LoadError)
# ~> 	from <internal:/usr/local/var/rbenv/versions/3.2.1/lib/ruby/site_ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:148:in `require'
# ~> 	from -:3:in `<main>'
