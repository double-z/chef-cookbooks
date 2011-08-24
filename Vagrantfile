Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("apt")
    chef.add_recipe("build-essential")
  end
end
