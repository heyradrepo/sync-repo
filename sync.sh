#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to clone or pull repository
clone_or_pull() {
    repo_url=$1
    repo_path=$2
    branch=$3

    if [ -d "$repo_path" ]; then
        # If directory exists, pull changes
        printf "Updating ${repo_path}... "
        cd "$repo_path" || exit
        git checkout "$branch" &> /dev/null
        git pull &> /dev/null
        if [ $? -eq 0 ]; then
            printf "${GREEN}Success${NC}\n"
        else
            printf "${RED}Failed${NC}\n"
        fi
        cd - || exit
    else
        # If directory doesn't exist, clone the repository
        printf "Cloning ${repo_url} into ${repo_path}... "
        if [ "$repo_path" == "kernel/xiaomi/mt6785" ]; then
            git clone --depth 1 --branch "$branch" "$repo_url" "$repo_path" &> /dev/null
        else
            git clone --branch "$branch" "$repo_url" "$repo_path" &> /dev/null
        fi
        if [ $? -eq 0 ]; then
            printf "${GREEN}Success${NC}\n"
        else
            printf "${RED}Failed${NC}\n"
        fi
    fi
}

# Clone or pull repositories with specified branches
clone_or_pull "https://github.com/heyradrepo/android_device_xiaomi_rosemary" "device/xiaomi/rosemary" "cherish"
clone_or_pull "https://github.com/heyradrepo/kernel_xiaomi_rosemary" "kernel/xiaomi/mt6785" "udc"
clone_or_pull "https://github.com/heyradrepo/hardware_mediatek" "hardware/mediatek" "lineage-21"
clone_or_pull "https://github.com/heyradrepo/hardware_xiaomi" "hardware/xiaomi" "lineage-21"
clone_or_pull "https://github.com/heyradrepo/android_device_mediatek_sepolicy_vndr" "device/mediatek/sepolicy_vndr" "lineage-21"
clone_or_pull "https://codeberg.org/heyradrepo/vendor_miuicameraleica" "vendor/MiuiCameraLeica" "udc"
