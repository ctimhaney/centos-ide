require 'yaml'
vars_file = "centos-ide-vars.yml"

if File.exist? vars_file
  runtime_vars = YAML.load_file(vars_file)

  Vagrant.configure("2") do |config|
    if runtime_vars["build_cent7"]
      config.vm.define "centos7-ide" do |cent7|
        cent7.vm.box = "bento/centos-7.7"
        cent7.vm.hostname = "cthidecent7"
        cent7.vm.network "private_network", ip: "192.168.50.3"
        cent7.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2201
        cent7.vm.provider "virtualbox" do |v|
            v.name = "CentOS 7 IDE"
            v.memory = runtime_vars["vm_memory"]
            v.cpus = runtime_vars["vm_cpus"]
        end
        cent7.vm.synced_folder ".", "/vagrant", disabled: false, mount_options: ["dmode=775", "fmode=775"]
        cent7.vm.provision :shell, inline: "/vagrant/bootstrap.sh"
        cent7.vm.provision :shell, inline: "sudo -iu vagrant git config --global user.name \"%s\"" % runtime_vars["git_config_user"]
        cent7.vm.provision :shell, inline: "sudo -iu vagrant git config --global user.email \"%s\"" % runtime_vars["git_config_email"]
      end
    end

    if runtime_vars["build_cent8"]
      config.vm.define "centos8-ide" do |cent8|
        cent8.vm.box = "bento/centos-8.1"
        cent8.vm.hostname = "cthidecent8"
        cent8.vm.network "private_network", ip: "192.168.50.4"
        cent8.vm.network "forwarded_port", id: "ssh", guest: 22, host: 2202
        cent8.vm.provider "virtualbox" do |v|
            v.name = "CentOS 8 IDE"
            v.memory = runtime_vars["vm_memory"]
            v.cpus = runtime_vars["vm_cpus"]
        end
        cent8.vm.synced_folder ".", "/vagrant", disabled: false, mount_options: ["dmode=775", "fmode=775"]
        cent8.vm.provision :shell, inline: "/vagrant/bootstrap.sh"
        cent8.vm.provision :shell, inline: "sudo -iu vagrant git config --global user.name \"%s\"" % runtime_vars["git_config_user"]
        cent8.vm.provision :shell, inline: "sudo -iu vagrant git config --global user.email \"%s\"" % runtime_vars["git_config_email"]
      end
    end
  end
end
