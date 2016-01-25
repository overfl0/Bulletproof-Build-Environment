# About
This is the Vagrant environment that creates a windows virtual machine that can be used to work on the [Tactical Battlefield](http://www.tacbf.com/) mod launcher and downloader.
This repository will be updated should new dependencies be added to the launcher source code.

# Prerequisites
Get Vagrant **1.6+**.

Ubuntu 14.04 LTS (and the likes) does NOT have the right version! You have to install it manually from vagrant's page.
If after running *vagrant up* you get errors about WinRM, **your vagrant installation is too old**.

# Howto
### Creating the Virtual Machine
```sh
$ git clone https://bitbucket.org/tacbf_launcher/build_environment.git
$ cd build_environment
$ vagrant box add Windows7_ie9 http://aka.ms/vagrant-win7-ie9 #This will download the microsoft image and will take some time
$ vagrant up
```

### First boot
**At first boot you have to enable WinRM for vagrant provisioning.** Unfortunately that windows image has it disabled so you have to do it manually.

When windows starts for the first time, open the file explorer and run:
```
E:\runme.bat
```

It's a script that enables WinRM automatically. After that, in about 10 seconds, the provisioning should start in the vagrant window (on the Host side). You can close the windows that will have popped out. They are here just so you can see the errors in case there are any (hopefully not!).

The provisioning scripts should install:

* Kivy (containing Python 2.7)
* Libtorrent
* Pyinstaller and other python requirements
* Git for Windows
* Notepad++
* LiClipse (PyDev)

A batch script to quickly clone the launcher repository should also be copied to c:\

# Using the Virtual Machine
### Cloning the launcher repository
The batch script *clone_tacbf_launcher.bat* to quickly clone the launcher repository should also be copied to c:\\. You can use it to quickly clone the launcher repository.

### Running the code
##### Recommended:
Use LiClipse which should already be configured to run the launcher (select default Workspace path on first LiClipse run). The file to run is ```launcher.py```


##### Manually:
Go to C:\Kivy-1.8.0-py2.7-win32 and run ```kivy.bat```. Navigate to the launcher repository and run ```python src\launcher.py```

##### Creating tblauncher.exe:
run ```kivy.bat``` and then execute ```build.bat``` from the command line.

### Other
##### Change VM settings
You can change some settings (like the amount of ram) by editing the Vagrantfile yourself. Most VM settings will be overridden by vagrant when running the VM (according to the Vagranfile). In order to be sure the changes are persistent, you have to modify that file instead of relying on VirtualBox GUI.

##### Starting
After halting the machine, to run it again, run:
```
vagrant up
```

##### Force provisioning
To force provisioning once you have created a VM, run:
```
vagrant up --provision
```
To force provisioning if you have the VM up and running, run:
```
vagrant provision
```

##### Reset the virtual machine
You can reset the VM to default by running:
```
vagrant destroy
vagrant up
```
*Note: The files downloaded by the provisioning scripts are kept intact while destroying the VM. This means they are downloaded only once which speeds up provisioning.*