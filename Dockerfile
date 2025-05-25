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

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /workspace/ComfyUI

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN mkdir -p custom_nodes && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# ⛔ Create empty checkpoints folder to prevent model download
RUN mkdir -p /workspace/ComfyUI/models/checkpoints

EXPOSE 3000

CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "3000"]
