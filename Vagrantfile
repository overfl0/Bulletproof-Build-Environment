# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Windows Guest Specific
  config.vm.box = "Windows7_ie9"
  config.vm.guest = :windows
  config.windows.set_work_network = true

  # port forwarding for RDP and WinRM
  config.vm.network "forwarded_port", guest: 3389, host: 3389
  config.vm.network "forwarded_port", guest: 5985, host: 5985, id: "winrm", auto_correct: true

  # WinRM Settings
  config.vm.communicator = "winrm"
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"

  config.windows.set_work_network = true

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    # Boot NOT in headless mode
    vb.gui = true

    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Folder that will contain the script to enable WinRM
    vb.customize ["sharedfolder", "add", :id, "--name", "enable_winrm", "--hostpath", File.dirname(__FILE__) + "/winrm", "--automount"]

    # uncomment the following line to have a folder shared with the vm and host
    # the name of your host folder must/should be tacbf_launcher_synced
    #vb.customize ["sharedfolder", "add", :id, "--name", "launcher_shared", "--hostpath", File.dirname(__FILE__) + "/tacbf_launcher_synced", "--automount"]

    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']  # Enable if needed
    vb.customize ["modifyvm", :id, "--memory", "1024"] # Set if you want more ram
    #vb.customize ["modifyvm", :id, "--cpus", "2"] # Does not work on some computers so I turned it off
    
  end

  # Max time to wait until the machine boots and winrm is run (in order to start provisioning)
  config.vm.boot_timeout = 500
  
  ##########################################################################
  # Provisioning
  ##########################################################################
  
  config.vm.provision :shell, :path => "SetupScripts/setup_requirements.cmd"

  
 
  #config.vm.provision "puppet" do |puppet|
  #  puppet.manifests_path = "manifests"
  #  puppet.manifest_file = "default.pp"
  #end
  

end
