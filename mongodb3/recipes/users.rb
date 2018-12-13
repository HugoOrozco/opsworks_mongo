include_recipe "mongodb3::mongo_gem"

require 'mongo'
require 'aws-sdk-opsworks'

::Chef::Recipe.send(:include, MongoDB::Helpers::User)

# Obtaning mongo instnaces

ruby_block 'Adding Admin User' do
    block do
        create_admin_user()
    end
end