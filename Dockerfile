FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    python3 \
    python3-pip \
    git \
    curl \
    libgl1 \
    libglib2.0-0 \
    && apt clean

WORKDIR /workspace

# ✅ Clone ComfyUI BEFORE creating folders inside it
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install ComfyUI Manager
RUN mkdir -p custom_nodes && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# ✅ Only now create empty checkpoints folder (no overwrite)
RUN mkdir -p /workspace/ComfyUI/models/checkpoints

EXPOSE 3000

CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "3000"]
