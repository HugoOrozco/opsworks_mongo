module MongoDB
    module Helpers
        module User

            require 'mongo'
            require 'aws-sdk-opsworks'

            def user_exists?(username, connection)
                connection['system.users'].find(user: username).count > 0
            end

            def create_admin_user()
                begin
                    username = node['DBUser']
                    password = node['DBPass']

                    begin
                        client = Mongo::Client.new([ '127.0.0.1:27017' ],:database => "admin" ,:connect => "direct", :server_selection_timeout => 5)
                        client.database_names
                    rescue
                        client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "admin", :user => username, :password => password,:connect => "direct", :server_selection_timeout => 5)
                    end
                rescue
                    Chef::Log.info "Failed to connect to database"
                end

                db = client.use('admin')
                roles = ['role': 'userAdminAnyDatabase', 'db': 'admin']
                create_user(username, password, roles, db, client)

            end

            def create_user(username, password, roles, db, client)
                begin
                    if !user_exists?(username, client)
                        db.database.users.create(
                                    username,
                                    password: password,
                                    roles: roles
                                    )
                    else
                        Chef::Log.info "User " + username + " already exists"
                    end
                rescue
                    Chef::Log.info "Could not create user: " + username
                end

            end

            def create_all_users()
                users = []
                roles = ['role': 'userAdminAnyDatabase', 'db': 'admin']
                user = [{'username': 'User1', 'password': 'test', 'roles': roles}]
                users.push(user)
                user2 = [{'username': 'User2', 'password': 'test', 'roles': roles}]
                users.push(user2)

                begin
                    client = Mongo::Client.new([ '127.0.0.1:27017' ],:database => "admin" ,:connect => "direct", :server_selection_timeout => 5)
                    client.database_names
                rescue
                    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "admin", :user => username, :password => password,:connect => "direct", :server_selection_timeout => 5)
                end
                
                db = client.use('admin')

                users.each do |user|
                    create_user(user[:username], user[:password], user[:roles], db, client)
                end
            end
        end
    end
end