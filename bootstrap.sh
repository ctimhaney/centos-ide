# check for major version 7
grep "release 7" /etc/redhat-release
if [ $? -eq 0 ]
then
  # Enable EPEL and install boilerplate Packages
  yum install -y epel-release
  yum install -y net-tools java-1.8.0-openjdk-* gcc openssl python3 wget dos2unix vim-enhanced ansible git ruby docker
fi

# check for major version 8
grep "release 8" /etc/redhat-release
if [ $? -eq 0 ]
then
  # Enable EPEL and install boilerplate Packages
  dnf install -y epel-release
  dnf install -y net-tools java-1.8.0-openjdk-* gcc openssl python3 wget dos2unix vim-enhanced ansible git ruby

  # CentOS 8 flavored docker-ce isntall
  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
  dnf install -y docker-ce
  systemctl start docker
  systemctl enable docker
fi

# golang installation
wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" > /home/vagrant/.bash_profile

# git configure
sudo -iu vagrant git config --global alias.co checkout
sudo -iu vagrant git config --global alias.ci commit
sudo -iu vagrant git config --global alias.st status
sudo -iu vagrant git config --global alias.br branch

# generate a key pair to authorize in git remotes
ssh-keygen -q -t RSA -b 2048 -f /home/vagrant/.ssh/id_rsa -N ''
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
