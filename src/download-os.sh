#!/bin/bash

# Create directory for OS images if it doesn't exist
mkdir -p os-images
cd os-images

# Function to download TinyCore Linux
download_tinycore() {
    echo "Downloading TinyCore Linux..."
    wget http://tinycorelinux.net/13.x/x86/release/TinyCore-current.iso
    
    # Create a disk image to install TinyCore on
    qemu-img create -f qcow2 tinycore.qcow2 1G
    
    echo "TinyCore Linux downloaded and disk image created."
}

# Function to download Alpine Linux
download_alpine() {
    echo "Downloading Alpine Linux..."
    wget https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.0-x86_64.iso
    
    # Create a disk image to install Alpine on
    qemu-img create -f qcow2 alpine.qcow2 2G
    
    echo "Alpine Linux downloaded and disk image created."
}

# Function to download Ubuntu Server
download_ubuntu() {
    echo "Downloading Ubuntu Server..."
    wget https://releases.ubuntu.com/22.04.1/ubuntu-22.04.1-live-server-amd64.iso
    
    # Create a disk image to install Ubuntu on
    qemu-img create -f qcow2 ubuntu.qcow2 4G
    
    echo "Ubuntu Server downloaded and disk image created."
}

# Function to download Raspberry Pi OS
download_raspberry_pi() {
    echo "Downloading Raspberry Pi OS..."
    wget https://downloads.raspberrypi.org/raspios_lite_armhf_latest -O raspios-lite.img.xz
    # Create a disk image to install Ubuntu on
    qemu-img create -f qcow2 raspberry.qcow2 4G
    echo "Raspberry Pi OS downloaded as raspios-lite.img.xz."
}

# Function to create a custom empty disk image
create_custom_disk() {
    size=$1
    name=$2
    
    qemu-img create -f qcow2 "${name}.qcow2" "${size}G"
    echo "Empty disk image ${name}.qcow2 of size ${size}GB created."
}

# Main menu
echo "Select an OS to download:"
echo "1) TinyCore Linux"
echo "2) Alpine Linux"
echo "3) Ubuntu Server"
echo "4) Raspberry Pi OS"
echo "5) Custom (Create empty disk image)"
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        download_tinycore
        ;;
    2)
        download_alpine
        ;;
    3)
        download_ubuntu
        ;;
    4)
        download_raspberry_pi
        ;;
    5)
        read -p "Enter size in GB for the disk image: " size
        read -p "Enter name for the disk image (without extension): " name
        create_custom_disk "$size" "$name"
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

echo "Done! You can now run the OS using the run-os.sh script."