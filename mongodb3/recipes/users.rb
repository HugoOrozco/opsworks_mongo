require 'mongo'
require 'aws-sdk-opsworks'

::Chef::Recipe.send(:include, MongoDB::Helpers::User)

# Obtaning mongo instnaces
this_instance = search("aws_opsworks_instance", "self:true").first
layer_id = this_instance["layer_ids"][0]

ruby_block 'Adding Admin User' do
    block do
        master_node_command = opsworks.describe_instances({
            layer_id: layer_id,
        })
        master_node = master_node_command.instances[0].hostname
        if master_node == this_instance["hostname"]
            create_admin_user()
        end
    end
end