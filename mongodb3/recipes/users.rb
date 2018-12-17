include_recipe "mongodb3::mongo_gem"

require 'mongo'
require 'aws-sdk-opsworks'


# Obtaning mongo instnaces
this_instance = search("aws_opsworks_instance", "self:true").first
layer_id = this_instance["layer_ids"][0]

opsworks = Aws::OpsWorks::Client.new(:region => "us-east-1")

ruby_block 'Adding Admin User' do
    block do
        master_node_command = opsworks.describe_instances({
            layer_id: layer_id,
        })
        master_node= master_node_command.instances[0].hostname
        if master_node == this_instance["hostname"]
            UserHelper.create_admin_user()
        end
    end
end