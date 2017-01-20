#!/bin/bash

IFS='/' read -a array <<< pwd

if [[ "$(pwd)" != *setup ]]
then
    cd ./setup
fi

version=$( lsb_release -r | grep -oP "[0-9]+" | head -1 )
if lsb_release -d | grep -q "Fedora"; then
	Release=Fedora
	dnf install -y python-devel m2crypto python-m2ext swig python-iptools python3-iptools libssl-dev
	pip install pycrypto
	pip install iptools
	pip install pydispatcher
	pip install flask
	pip install pyOpenSSL
elif lsb_release -d | grep -q "Kali"; then
	Release=Kali
	apt-get install -y python-dev python-m2crypto swig python-pip libssl-dev
	pip install pycrypto
	pip install iptools
	pip install pydispatcher
	pip install flask
	pip install pyOpenSSL
elif lsb_release -d | grep -q "Ubuntu"; then
	Release=Ubuntu
	apt-get install -y python-dev python-m2crypto swig python-pip libssl-dev
	pip install pycrypto
	pip install iptools
	pip install pydispatcher
	pip install flask
	pip install pyOpenSSL
else
	echo "Unknown distro - Debian/Ubuntu Fallback"
	 apt-get install -y python-dev python-m2crypto swig python-pip libssl-dev
	 pip install pycrypto
	 pip install iptools
	 pip install pydispatcher
	 pip install flask
	 pip install pyOpenSSL
fi

# set up the database schema
./setup_database.py

# generate a cert
./cert.sh

cd ..

echo -e '\n [*] Setup complete!\n'
