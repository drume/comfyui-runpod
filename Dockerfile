# Base OS
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN apt update && apt install -y \
    python3 \
    python3-pip \
    git \
    curl \
    libgl1 \
    libglib2.0-0 \
    && apt clean

# Set working directory
WORKDIR /workspace

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Move into ComfyUI directory
WORKDIR /workspace/ComfyUI

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install ComfyUI Manager
RUN mkdir -p /workspace/ComfyUI/custom_nodes && \
    cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Expose the ComfyUI port
EXPOSE 3000

# Run ComfyUI
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "3000"]
