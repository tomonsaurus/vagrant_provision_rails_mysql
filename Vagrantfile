Vagrant.configure("2") do |config|
  config.vm.box = "centos64-x86_64-20140116.box"
  
  
  
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.4.2/centos64-x86_64-20140116.box"
  config.vm.synced_folder ".", "/vagrant", :mount_options => ['dmode=775', 'fmode=664']
  
  config.vm.network "private_network", ip: "192.168.33.10"
  
  config.vm.provision "shell", :path => "provision.sh", privileged: false
end
