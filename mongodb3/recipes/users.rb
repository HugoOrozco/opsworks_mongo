include_recipe "mongodb3::mongo_gem"

require 'mongo'
require 'aws-sdk-opsworks'


# Obtaning mongo instnaces

ruby_block 'Adding Admin User' do
    block do
        UserHelper.create_admin_user()
    end
end