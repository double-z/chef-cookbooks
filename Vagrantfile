Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"

    # TODO Refactor
    chef.add_role "rnet-admin"
    chef.add_role "rnet-wordpress"
  end
end
