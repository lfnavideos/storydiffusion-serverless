# StoryDiffusion - RunPod Serverless
# Template customizado para "A Bíblia em Vídeos"
# Consistência de personagens bíblicos através de múltiplas cenas

FROM runpod/pytorch:2.2.0-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependências Python base
RUN pip install --no-cache-dir \
    runpod \
    requests \
    pillow \
    numpy \
    scipy

# Atualizar huggingface_hub PRIMEIRO (fix para split_torch_state_dict_into_shards)
RUN pip install --no-cache-dir --upgrade huggingface_hub>=0.24.0

# Instalar PyTorch e dependências de ML
RUN pip install --no-cache-dir \
    diffusers>=0.30.0 \
    transformers>=4.44.0 \
    accelerate>=0.30.0 \
    safetensors

# Instalar dependências para PhotoMaker/StoryDiffusion
RUN pip install --no-cache-dir \
    insightface \
    onnxruntime-gpu \
    opencv-python-headless

# Clonar StoryDiffusion
RUN git clone https://github.com/HVision-NKU/StoryDiffusion.git /app/StoryDiffusion

# Instalar dependências do StoryDiffusion
RUN pip install --no-cache-dir -r /app/StoryDiffusion/requirements.txt || true

# FORÇAR versões corretas DEPOIS de tudo (fix para split_torch_state_dict_into_shards)
RUN pip install --no-cache-dir --force-reinstall \
    huggingface_hub==0.25.2 \
    transformers==4.46.0 \
    diffusers==0.31.0

# Copiar handler customizado
COPY handler.py /app/handler.py
COPY characters.json /app/characters.json

# Pré-baixar modelos base (opcional - aumenta tamanho mas acelera cold start)
# Descomentando baixa ~15GB de modelos
# RUN python -c "from diffusers import StableDiffusionXLPipeline; StableDiffusionXLPipeline.from_pretrained('stabilityai/stable-diffusion-xl-base-1.0', torch_dtype=torch.float16)"

# Variáveis de ambiente - usar /runpod-volume para cache (mais espaço)
ENV PYTHONUNBUFFERED=1
ENV HF_HOME=/runpod-volume/huggingface
ENV TRANSFORMERS_CACHE=/runpod-volume/huggingface
ENV HUGGINGFACE_HUB_CACHE=/runpod-volume/huggingface
ENV TORCH_HOME=/runpod-volume/torch

# Comando de execução
CMD ["python", "-u", "/app/handler.py"]
