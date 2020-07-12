touch /tmp/bootstrap-install.log
# check for major version 7
grep "release 7" /etc/redhat-release
if [ $? -eq 0 ]
then
  # Enable EPEL and install boilerplate Packages
  echo "Installing EPEL..."
  yum install -y epel-release >> /tmp/bootstrap-install.log
  echo "Installing Packages..."
  yum install -y net-tools java-1.8.0-openjdk-* gcc openssl openssl-devel python3 dos2unix vim-enhanced ansible git ruby htop zlib-devel bzip2-devel readline-devel sqlite-devel glibc less unzip >> /tmp/bootstrap-install.log

  # docker install
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  echo "Installing docker..."
  yum install -y docker-ce >> /tmp/bootstrap-install.log
fi

# check for major version 8
grep "release 8" /etc/redhat-release
if [ $? -eq 0 ]
then
  # Enable EPEL and install boilerplate Packages
  echo "Installing EPEL..."
  dnf install -y epel-release >> /tmp/bootstrap-install.log
  echo "Installing Packages..."
  dnf install -y net-tools java-1.8.0-openjdk-* gcc openssl openssl-devel python3 dos2unix vim-enhanced ansible git ruby htop zlib-devel bzip2-devel readline-devel sqlite-devel glibc less unzip >> /tmp/bootstrap-install.log

  # CentOS 8 flavored docker-ce isntall
  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  echo "Installing docker..."
  dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm >> /tmp/bootstrap-install.log
  dnf install -y docker-ce >> /tmp/bootstrap-install.log
fi

systemctl start docker
systemctl enable docker
usermod -aG docker vagrant

# golang installation
curl -s -X GET "https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz" -o "go1.linux-amd64.tar.gz"
tar -C /usr/local -xzf "go1.linux-amd64.tar.gz"
echo 'export "PATH=$PATH:/usr/local/go/bin"' >> /home/vagrant/.bash_profile

# git configure
sudo -iu vagrant git config --global alias.co checkout
sudo -iu vagrant git config --global alias.ci commit
sudo -iu vagrant git config --global alias.st status
sudo -iu vagrant git config --global alias.br branch

# generate a key pair to authorize in git remotes
ssh-keygen -q -t RSA -b 2048 -f /home/vagrant/.ssh/id_rsa -N ''
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*

# pyenv installation
sudo -iu vagrant git clone https://github.com/pyenv/pyenv.git /home/vagrant/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/vagrant/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/vagrant/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> /home/vagrant/.bash_profile

# AWS-CLI version 2
curl -s -X GET "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
echo "Installing aws-cli..."
aws/install >> /tmp/bootstrap-install.log

# Gradle Install
wget https://services.gradle.org/distributions/gradle-6.5.1-bin.zip
mkdir /opt/gradle
unzip -d /opt/gradle gradle-6.5.1-bin.zip
ln -s /opt/gradle/gradle-6.5.1/bin/gradle /usr/local/bin/gradle
