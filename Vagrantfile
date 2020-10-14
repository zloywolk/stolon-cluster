# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

if defined?(VagrantVbguest)
  class InstallerCentOs8 < VagrantVbguest::Installers::CentOS
    protected
    
    def has_rel_repo?
      unless instance_variable_defined?(:@has_rel_repo)
        rel = release_version
        @has_rel_repo = communicate.test(centos_8? ? 'yum repolist' : "yum repolist --enablerepo=C#{rel}-base --enablerepo=C#{rel}-updates")
      end
      @has_rel_repo
    end

    def centos_8?
      release_version && release_version.to_s.start_with?('8')
    end

    def install_kernel_devel(opts=nil, &block)
      if centos_8?
        communicate.sudo('yum update -y kernel', opts, &block)
        communicate.sudo('yum install -y kernel-devel', opts, &block)
        communicate.sudo('shutdown -r now', opts, &block)

        begin
          sleep 10
        end until @vm.communicate.ready?
      else
        rel = has_rel_repo? ? release_version : '*'
        cmd = "yum install -y kernel-devel-`uname -r` --enablerepo=C#{rel}-base --enablerepo=C#{rel}-updates"
        communicate.sudo(cmd, opts, &block)
      end
    end
  end
end

NodeCount = 3

Vagrant.configure("2") do |config|

  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  (1..NodeCount).each do |index|
    config.vm.define "pdb0#{index}" do |node|
      node.vm.box = "centos/8"
      node.vm.box_version = "1905.1"
      node.vbguest.installer = InstallerCentOs8
      
      node.vm.network "public_network", ip: "192.168.0.3#{index}"
      node.vm.hostname = "pdb0#{index}"

      node.vm.provider "virtualbox" do |v|
        v.name = "pdb0#{index}"
        v.memory = 2048
        v.cpus = 2
      end

      node.vm.provision "shell", path: "scripts/install_postgresql11.sh"
    end
  end

  config.vm.define "ansible" do |node|
    node.vm.box = "centos/8"
    node.vm.box_version = "1905.1"
    node.vbguest.installer = InstallerCentOs8

    node.vm.network "public_network", ip: "192.168.0.34"
    node.vm.hostname = "ansible"

    node.vm.provider "virtualbox" do |v|
      v.name = "ansible"
      v.memory = 2048
      v.cpus = 1
    end
  end
end
