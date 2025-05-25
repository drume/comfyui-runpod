# Base OS
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required system packages
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

# Clone the official ComfyUI repo
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Set working dir to ComfyUI folder
WORKDIR /workspace/ComfyUI

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose the port ComfyUI runs on
EXPOSE 3000

# Launch ComfyUI
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "3000"]
