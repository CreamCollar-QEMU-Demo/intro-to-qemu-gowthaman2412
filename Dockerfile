FROM ubuntu:22.04

# Set the environment variable to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install QEMU and necessary tools
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    curl \
    wget \
    unzip \
    python3 \
    python3-pip \
    novnc \
    websockify \
    locales \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* 

# Generate the locale and set it
RUN locale-gen en_IN.UTF-8
ENV LANG=en_IN.UTF-8 \
    LANGUAGE=en_IN:en \
    LC_ALL=en_IN.UTF-8

# Create a working directory for OS images
WORKDIR /os-exploration

# This volume will be used to share files between host and container
VOLUME ["/os-images"]

# Expose VNC and noVNC ports
EXPOSE 5900
EXPOSE 6080

# Default command to keep container running
CMD ["bash"]