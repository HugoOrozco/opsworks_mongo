include_recipe "mongodb3::mongo_gem"

require 'json'
require 'mongo'
require 'bson'
require 'aws-sdk-opsworks'
require 'aws-sdk-route53'
require 'aws-sdk-ssm'

# Obtaning mongo instnaces
this_instance = search("aws_opsworks_instance", "self:true").first
layer_id = this_instance["layer_ids"][0]

node.default['mongodb3']['config']['mongod']['net']['port'] = node['DBPort']

ssm = Aws::SSM::Client.new(:region => "#{node['Region']}")
userParam = ssm.get_parameter({
    name: "#{node['DBUser']}",
    with_decryption: false
})
user = userParam[:parameter][:value]
passwordParam = ssm.get_parameter({
    name: "#{node['DBPassword']}",
    with_decryption: false
})
password = passwordParam[:parameter][:value]

begin
  mongo = Mongo::Client.new([ "127.0.0.1:#{node['mongodb3']['config']['mongod']['net']['port']}" ], :database => "admin", :user => user, :password => password, :connect => "direct", :server_selection_timeout => 5)
  mongo.database_names
rescue
  mongo = Mongo::Client.new([ "127.0.0.1:#{node['mongodb3']['config']['mongod']['net']['port']}" ], :database => "admin", :connect => "direct", :server_selection_timeout => 5)
end

opsworks = Aws::OpsWorks::Client.new(:region => "us-east-1")
dns = Aws::Route53::Client.new(:region => "#{node['Region']}")

ruby_block 'Removing Host' do
  block do
    dnsrsets = dns.list_resource_record_sets({
      hosted_zone_id: "#{node['HostedZoneId']}",
    })

    dnsrsets.resource_record_sets.each do |old_record|
      if "#{old_record.resource_records[0].value}" == "#{this_instance["private_ip"]}"
        Chef::Log.info "Removing RecordSet: " + old_record.name.to_s
        resp = dns.change_resource_record_sets({
          change_batch: {
            changes: [
              {
                action: "DELETE",
                resource_record_set: {
                  name: "#{old_record.name}",
                  resource_records: [
                    {
                      value: "#{old_record.resource_records[0].value}",
                    },
                  ],
                  ttl: 60,
                  type: "A",
                },
              },
            ],
            comment: "Mongo service discovery for #{node['HostID']}",
          },
          hosted_zone_id: "#{node['HostedZoneId']}",
        })
      end
    end
  end
end
