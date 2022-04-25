#!/bin/bash
ubuntu@ubuntu-work-20-04:~/ec2-scripts-repo/ec2_ubuntu_scripts$ sudo apt install  openjdk-11-jdk
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
##The following packages were automatically installed and are no longer required:
#  gyp javascript-common libc-ares2 libfwupdplugin1 libjs-inherits libjs-is-typedarray libjs-psl libjs-typedarray-to-buffer libpython2-stdlib
#  libpython2.7-minimal libpython2.7-stdlib libssl-dev libuv1-dev python-pkg-resources python2 python2-minimal python2.7 python2.7-minimal
#Use 'sudo apt autoremove' to remove them.
#The following additional packages will be installed:
#  ca-certificates-java fonts-dejavu-extra java-common libatk-wrapper-java libatk-wrapper-java-jni libice-dev libpthread-stubs0-dev libsm-dev libx11-dev
#  libxau-dev libxcb1-dev libxdmcp-dev libxt-dev openjdk-11-jdk-headless openjdk-11-jre openjdk-11-jre-headless x11proto-core-dev x11proto-dev
#  xorg-sgml-doctools xtrans-dev
#Suggested packages:
#  default-jre libice-doc libsm-doc libx11-doc libxcb-doc libxt-doc openjdk-11-demo openjdk-11-source visualvm fonts-ipafont-gothic fonts-ipafont-mincho
#  fonts-wqy-microhei | fonts-wqy-zenhei fonts-indic
#The following NEW packages will be installed:
#  ca-certificates-java fonts-dejavu-extra java-common libatk-wrapper-java libatk-wrapper-java-jni libice-dev libpthread-stubs0-dev libsm-dev libx11-dev
#  libxau-dev libxcb1-dev libxdmcp-dev libxt-dev openjdk-11-jdk openjdk-11-jdk-headless openjdk-11-jre openjdk-11-jre-headless x11proto-core-dev
#  x11proto-dev xorg-sgml-doctools xtrans-dev
#0 upgraded, 21 newly installed, 0 to remove and 0 not upgraded.
#Need to get 266 MB of archives.
#After this operation, 421 MB of additional disk space will be used.
#Do you want to continue? [Y/n] n
echo "Installing OpenJDK-11 on ${HOSTAME}..."
sudo apt install -y openjdk-11-jdk openjdk-11-demo visualvm
echo "Installation complete..."
