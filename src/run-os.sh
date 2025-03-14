#!/bin/bash

# Check if image file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <os-image> [memory-in-mb] [additional-qemu-options]"
    echo "Example: $0 alpine.qcow2 1024"
    echo "Example with ISO: $0 alpine.qcow2 1024 \"-cdrom alpine-virt-3.16.0-x86_64.iso -boot d\""
    exit 1
fi

IMAGE="$1"
MEMORY="${2:-512}"  # Default to 512MB if not specified
ADDITIONAL_OPTS="${3:-}"  # Additional QEMU options

# Run QEMU with the specified OS image
echo "Starting QEMU with image: $IMAGE"
echo "Memory: $MEMORY MB"
echo "Additional options: $ADDITIONAL_OPTS"

eval qemu-system-x86_64 \
    -m "$MEMORY" \
    -hda "$IMAGE" \
    $ADDITIONAL_OPTS \
    -display vnc=:0