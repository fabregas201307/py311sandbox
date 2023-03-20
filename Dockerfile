FROM ubuntu:latest

WORKDIR /app
COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget bzip2 && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh

# Set up shell
RUN /opt/conda/bin/conda init bash

# Create conda environment
RUN /bin/bash -c "/opt/conda/bin/conda create -y --name research && \
                  source /opt/conda/etc/profile.d/conda.sh && \
                  conda activate research && \
                  /opt/conda/bin/conda install -y pip && \
                  /opt/conda/envs/research/bin/pip install -r requirements.txt && \
                  conda deactivate"

# Clean up
RUN /opt/conda/bin/conda clean -afy && \
    rm -rf /root/.cache/pip/* && \
    rm -rf /root/.cache/conda/*

# Set environment variables
ENV PATH /opt/conda/envs/research/bin:$PATH
