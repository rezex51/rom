#!/bin/bash

# Upgrade System
sudo apt update && sudo apt upgrade -y

#Initiating Crdroid
echo "========================================================================"
echo "INITIALIZING ROM REPOSITORY"
echo "========================================================================"

repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

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

rm -rf device/oneplus/larry
rm -rf device/oneplus/sm6375-common
rm -rf vendor/motorola/fogos
rm -rf vendor/motorola/sm6375-common
rm -rf kernel/motorola/sm6375


echo "========================================================================"
echo "DELETED DIRECTORIES SUCCESSFULLY"
echo "========================================================================"

#Clone Resources
echo "========================================================================"
echo "CLONING BASIC MUNCH RESOURCES"
echo "========================================================================"

#1. Device Tree
git clone https://github.com/NeonWarrior478/android_device_motorola_fogos.git -b fourteen device/motorola/fogos

#2. Common Device Tree
git clone https://github.com/NeonWarrior478/android_device_motorola_sm6375-common.git -b fourteen device/motorola/sm6375-common

#3. Vendor Tree
git clone https://github.com/NeonWarrior478/proprietary_vendor_motorola_fogos.git -b fourteen vendor/motorola/fogos 

#4. Common Vendor Tree
git clone https://github.com/NeonWarrior478/proprietary_vendor_motorola_sm6375-common.git  -b fourteen vendor/motorola/sm6375-common

#5. Kernel Tree
git clone https://github.com/NeonWarrior478/android_kernel_motorola_sm6375.git  -b fourteen kernel/motorola/sm6375

echo "========================================================================"
echo "BASIC MUNCH RESOURCES CLONED SUCCESSFULLY"
echo "========================================================================"


#Modifications
echo "========================================================================"
echo "MODIFICATIONS STARTED"
echo "========================================================================"


echo "========================================================================"
echo "MODIFICATIONS DONE SUCCESSFULLY"
echo "========================================================================"

#Build Commands
echo "========================================================================"
echo "BUILD STARTING"
echo "========================================================================"

source build/envsetup.sh
lunch aosp_fogos-ap2a-userdebug
mka bacon
