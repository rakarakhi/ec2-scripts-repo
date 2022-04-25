#!/bin/bash
#Installing Python 2.7 and Python 3
#Reference: https://askubuntu.com/questions/101591/how-do-i-install-the-latest-python-2-7-x-or-3-x-on-ubuntu
#
#
# refreshing the repositories
sudo apt update
# its wise to keep the system up to date!
# you can skip the following line if you not
# want to update all your software
sudo apt upgrade -y
# installing python 2.7 and pip for it
sudo apt install -y  python2 
sudo apt install -y  python-pip
# installing python-pip for 3.6
sudo apt install -y python3-pip
echo "Python Version Check..."
python2 --version
echo ""
python3 --version
echo ""
type python python2 python3 pip pip2 pip3
#python is /usr/bin/python
#python2 is hashed (/usr/bin/python2)
#python3 is hashed (/usr/bin/python3)
#pip is /usr/bin/pip
#pip2 is /usr/bin/pip2
#pip3 is /usr/bin/pip3
#
pip --version
#pip 8.1.1 from /usr/lib/python2.7/dist-packages (python 2.7)
#
pip3 --version
#pip 8.1.1 from /usr/lib/python3/dist-packages (python 3.5)
#
python2 -m pip --version
#pip 8.1.1 from /usr/lib/python2.7/dist-packages (python 2.7)
#
python3 -m pip --version
#pip 8.1.1 from /usr/lib/python3/dist-packages (python 3.5)

#And one last thing before you can go and start installing all your favorite python PyPI modules: you'll probably have to upgrade pip itself (both pip2 and pip3, separately; also, it doesn't matter if pip is invoked via the python executables or the pip executables, the actual upgrades are stored in /usr/lib):
#
sudo -H python2 -m pip install --upgrade pip
sudo -H python3 -m pip install --upgrade pip

#You can now run either the stand-alone pip or the version bundled within python (via python -m pip {command}).

