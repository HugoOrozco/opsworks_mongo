require 'mongo'
require 'aws-sdk-opsworks'
require 'aws-sdk-ssm'

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
            ssm = Aws::SSM::Client.new(:region => "#{node['Region']}")

            username = ssm.get_parameter({
                name: "mongoUser",
                with_decryption: false
            })
            password = ssm.get_parameter({
                name: "mongoPass",
                with_decryption: false
            })
            port = node['mongodb3']['config']['mongod']['net']['port']
            UserHelper.create_admin_user(username, password, port)
        end
    end
end