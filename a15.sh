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
rm -rf vendor/oneplus/larry
rm -rf vendor/oneplus/sm6375-common
rm -rf kernel/oneplus/sm6375


echo "========================================================================"
echo "DELETED DIRECTORIES SUCCESSFULLY"
echo "========================================================================"

#Clone Resources
echo "========================================================================"
echo "CLONING BASIC MUNCH RESOURCES"
echo "========================================================================"

#1. Device Tree
git clone https://github.com/rezex51/android_device_oneplus_larry.git -b 15 device/oneplus/larry

#2. Common Device Tree
git clone https://github.com/rezex51/android_device_oneplus_sm6375-common.git -b 15 device/oneplus/sm6375-common

#3. Vendor Tree
git clone https://github.com/rezex51/proprietary_vendor_oneplus_larry.git -b 15 vendor/oneplus/larry

#4. Common Vendor Tree
git clone https://github.com/rezex51/proprietary_vendor_oneplus_sm6375-common.git -b 15 vendor/oneplus/sm6375-common

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
