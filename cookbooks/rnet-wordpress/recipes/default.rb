include_recipe "wordpress-nginx"

wordpress_users = data_bag("wordpress-users")

wordpress_users.each do |user|
  user_data = data_bag_item("wordpress-users", user)
  user_data["blogs"].each do |blog|
    remote_file "/home/#{user}/wordpress-#{blog["version"]}.tar.gz" do
      checksum node['wordpress']['checksum']
      source "http://wordpress.org/wordpress-#{blog["version"]}.tar.gz"
      mode "0644"
    end

=begin    
    directory "#{node['wordpress']['dir']}" do
      owner "root"
      group "root"
      mode "0755"
      action :create
      recursive true
    end
    
    execute "untar-wordpress" do
      cwd node['wordpress']['dir']
      command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.tar.gz"
      creates "#{node['wordpress']['dir']}/wp-settings.php"
    end
    
    execute "mysql-install-wp-privileges" do
      command "/usr/bin/mysql -u root -p#{node['mysql']['server_root_password']} < #{node['mysql']['conf_dir']}/wp-grants.sql"
      action :nothing
    end
    
    template "#{node['mysql']['conf_dir']}/wp-grants.sql" do
      source "grants.sql.erb"
      owner "root"
      group "root"
      mode "0600"
      variables(
                :user     => node['wordpress']['db']['user'],
                :password => node['wordpress']['db']['password'],
                :database => node['wordpress']['db']['database']
                )
      notifies :run, "execute[mysql-install-wp-privileges]", :immediately
    end
    
    execute "create #{node['wordpress']['db']['database']} database" do
      command "/usr/bin/mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['wordpress']['db']['database']}"
      not_if do
        require 'mysql'
        m = Mysql.new("localhost", "root", node['mysql']['server_root_password'])
        m.list_dbs.include?(node['wordpress']['db']['database'])
      end
      notifies :create, "ruby_block[save node data]", :immediately
    end
    
    # save node data after writing the MYSQL root password, so that a failed chef-client run that gets this far doesn't cause an unknown password to get applied to the box without being saved in the node data.
    ruby_block "save node data" do
      block do
        node.save
      end
      action :create
    end
    
    log "Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation" do
      action :nothing
    end
    
    template "#{node['wordpress']['dir']}/wp-config.php" do
      source "wp-config.php.erb"
      owner "root"
      group "root"
      mode "0644"
      variables(
                :database        => node['wordpress']['db']['database'],
                :user            => node['wordpress']['db']['user'],
                :password        => node['wordpress']['db']['password'],
                :auth_key        => node['wordpress']['keys']['auth'],
                :secure_auth_key => node['wordpress']['keys']['secure_auth'],
                :logged_in_key   => node['wordpress']['keys']['logged_in'],
                :nonce_key       => node['wordpress']['keys']['nonce']
                )
      notifies :write, "log[Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation]"
=end
  end
end
