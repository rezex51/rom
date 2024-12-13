#!/bin/bash

# Upgrade System
sudo apt update && sudo apt upgrade -y

#Initiating PixelOS
echo "========================================================================"
echo "INITIALIZING ROM REPOSITORY"
echo "========================================================================"

repo init -u https://github.com/yaap/manifest.git -b fifteen --git-lfs

echo "========================================================================"
echo "ROM REPOSITORY INITIALIZED SUCCESSFULLY"
echo "========================================================================"

#Resync
echo "========================================================================"
echo "RESYNCING SOURCE"
echo "========================================================================"

/opt/crave/resync.sh

#Remove Device Resources (if any)
echo "========================================================================"
echo "DELETING DIRECTORIES"
echo "========================================================================"

rm -rf device/xiaomi/spes
rm -rf vendor/xiaomi/spes
rm -rf kernel/xiaomi/sm6225


echo "========================================================================"
echo "DELETED DIRECTORIES SUCCESSFULLY"
echo "========================================================================"

#Clone Resources
echo "========================================================================"
echo "CLONING BASIC MUNCH RESOURCES"
echo "========================================================================"

#1. Device Tree
git clone https://github.com/rezex51/device_xiaomi_spes.git -b 15 device/xiaomi/spes

#3. Vendor Tree
git clone https://github.com/rezex51/vendor_xiaomi_spes.git -b 15 vendor/xiaomi/spes

#4. Kernel Tree
git clone https://github.com/muralivijay/kernel_xiaomi_sm6225.git -b main kernel/xiaomi/sm6225

echo "========================================================================"
echo "BASIC MUNCH RESOURCES CLONED SUCCESSFULLY"
echo "========================================================================"


#Modifications
echo "========================================================================"
echo "MODIFICATIONS STARTED"
echo "========================================================================"

#1. Neutron Clang
cd prebuilts/clang/host/linux-x86
mkdir clang-neutron
cd clang-neutron
curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
chmod +x antman
./antman -S=05012024
./antman --patch=glibc
cd ../../../../..


echo "========================================================================"
echo "MODIFICATIONS DONE SUCCESSFULLY"
echo "========================================================================"

#Build Commands
echo "========================================================================"
echo "BUILD STARTING"
echo "========================================================================"

source build/envsetup.sh
lunch yaap-spes-userdebug
m yaap
