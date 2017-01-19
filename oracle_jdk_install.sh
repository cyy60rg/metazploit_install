#!/bin/bash

#check for sudo
#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 
#   exit 1
#fi

if [ $# -eq 0 ]
then
  echo "You should specify java file as argument"
  exit 1
elif [ $# -gt 1 ]
then
  echo "Specify only the java installation tar file"
  exit 1
else 
  echo "Installation starts now"
fi 

if [ ${1: -3} != ".gz" ]
then
  echo "Yous should give a tar file"
  exit 1
fi

jvm_path='/usr/lib/jvm/'
java_file=$1

sudo mkdir -p $jvm_path
#get the folder which will be extracted
file_n=$(tar tf $1 | awk -F/ '{if (NF=1) print }' | awk 'NR==1; END{}')

sudo tar xvf $java_file -C $jvm_path 

#echo "aa"
#echo "${file_n}"

sudo update-alternatives --install "/usr/bin/java" "java" "${jvm_path}${file_n}/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "${jvm_path}${file_n}/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "${jvm_path}${file_n}/bin/javaws" 1

sudo chmod a+x /usr/bin/java
sudo chmod a+x /usr/bin/javac
sudo chmod a+x /usr/bin/javaws
sudo chown -R root:root ${jvm_path}${file_n}

sudo update-alternatives --config java
sudo update-alternatives --config javac
sudo update-alternatives --config javaws

#mkdir -p /usr/lib/jvm
