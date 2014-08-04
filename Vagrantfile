# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'centos'
  config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box'
  config.vm.network :private_network, :ip => '192.168.0.5'

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.run_list = ['recipe[pptpd]']
    chef.json = {
      :pptpd => {
        :chap_secrets => [
          {
            client: 'guest',
            secret: 'guest',
            address: '*',
          }
        ]
      }
    }
  end
end
