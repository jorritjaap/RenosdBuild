#!/bin/bash
# script to build renosd 
#
# Simply run this script as SUDO to build renosd
#
# Requirements:
# -Ubuntu Ubuntu Xenial (16.04) (Will not work 12.04 or lower)
# -Root access
# -about 10-15 minutes to run and install everything
# (this scrip was test using fresh install of Ubuntu)
#
# Tasks perfomed by script:
# 1. install all depencies
# 2. clones renos code
# 3. builds the code
#
# Why Renosd 
# This scripts builds the renosd on an Ubuntu box.
# Renosd can be used to run a full Renos node.
# Full node is usefull for RCP service with you wallet
# or to run a masternode.

# 1. Dependendies
sudo apt-get update -y
 # 1a build tools
sudo apt-get install build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils -y
# 1b boost
sudo apt-get install libboost-all-dev -y
# 1c BerkeleyDB 
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
# 1d Git
sudo apt-get install git -y

# 2. clones renos code
cd .. # go to repo folder
git clone https://github.com/RenosCoin/RenosCoin.git


# 3. Build
# 3a Setup 
mkdir RenosCoin/src/obj/crypto
sudo chmod 755 RenosCoin/src/leveldb/*
# 3b Build secp256k1 
cd RenosCoin/src/secp256k1
sudo bash autogen.sh
sudo ./configure -prefix=/usr
sudo make install
cd ..
cd ..

# 3c Build Renos
cd src && make -f makefile.unix USE_UPNP=- && strip renosd
