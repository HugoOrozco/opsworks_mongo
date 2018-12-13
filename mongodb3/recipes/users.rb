include_recipe "mongodb3::mongo_gem"

require 'mongo'
require 'aws-sdk-opsworks'
require '../libraries/users'

::Chef::Recipe.send(:include, UserHelper)

# Obtaning mongo instnaces

ruby_block 'Adding Admin User' do
    block do
        create_admin_user()
    end
end