Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.provision :shell, :path => "scripts/setup.sh"
    #Uncomment the below two line to expose common JHipster web ports.
    #config.vm.network :forwarded_port, host: 8080, guest: 8080
    #config.vm.network :forwarded_port, host: 9000, guest: 9000

	#To speed up multiple vagrant builds, use ..  Uncomment the below.
	#config.vm.network :private_network, ip: '10.10.10.4'
    config.ssh.insert_key = true
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider :virtualbox do |vb|
        vb.gui = true
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--name", "Ubuntu Devbox (JHipster)"]
        vb.customize ["modifyvm", :id, "--memory", "4096"]
        vb.customize ["modifyvm", :id, "--vram", 64]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
        vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
        vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
	#If using an SSD on the machine running the VM, uncomment the below
        #vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller','--port', '0', '--nonrotational', 'on']
    end
end
