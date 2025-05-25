# Base OS: Ubuntu 22.04 with essential packages
FROM ubuntu:22.04

# Prevents interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install Python, Git, and required libs
RUN apt update && apt install -y \
    python3 \
    python3-pip \
    git \
    wget \
    curl \
    libgl1 \
    libglib2.0-0 \
    && apt clean

# Create workspace
WORKDIR /workspace

# Clone official ComfyUI repo
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
