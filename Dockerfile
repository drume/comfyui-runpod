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

# Move into the ComfyUI directory
WORKDIR /workspace/ComfyUI

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install ComfyUI Manager as a custom node
RUN mkdir -p /workspace/ComfyUI/custom_nodes && \
    cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Expose ComfyUI web port
EXPOSE 3000

# Launch ComfyUI when the container starts
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "3000"]
