
#!/bin/bash

jdk_file=$1
java_flag=0

sudo apt-get update -y 
sudo apt-get upgrade -y 

if [[ $(type -p java) ]]; then
  if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then 
    echo 'Openjdk installed'
    java_flag=0
  else 
    echo 'Oracle java installed'
    update-alternatives --display java
    echo 'Inspect above text'
    read -p "Do U want to install [Y/N]" yn
    echo "Value: $yn"	
    if [[  $yn =~ ^[yY]$ ]]
    then		
      java_flag=0
    elif [[ $yn =~ ^[nN]$ ]]
    then
      java_flag=1

    fi

  fi

fi

if [ "$java_flag" -eq 0 ] ; then
  ./oracle_jdk_install.sh $jdk_file
else
  echo "Not installing"
  
fi

sudo apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev curl zlib1g-dev -y

# Ruby Installation

cd ~

git clone git://github.com/sstephenson/rbenv.git .rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

echo 'eval "$(rbenv init -)"' >> ~/.bashrc

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo

#exec $SHELL

RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O - )

rbenv install $RUBYVERSION

rbenv global $RUBYVERSION

ruby -v

# Nmap installation

mkdir ~/Development

cd ~/Development

git clone https://github.com/nmap/nmap.git

cd nmap 

./configure

make

sudo make install

make clean

echo ""
echo ""
echo "--->                                                 <---"
echo "--->                                                 <---"
echo "---> Type the commands in ''postgres_db_config.txt'' <---"
echo "--->                                                 <---"
echo "--->                                                 <---"
echo ""
echo ""

sudo -s

cd /opt

sudo git clone https://github.com/rapid7/metasploit-framework.git

sudo chown -R `whoami` /opt/metasploit-framework

cd metasploit-framework

gem install bundler

bundle install

sudo bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
